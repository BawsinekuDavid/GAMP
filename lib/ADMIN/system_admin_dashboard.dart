import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmarket_app/ADMIN/product_form.dart';
import 'package:gmarket_app/models/category_module.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../Endpoints/categoryapi.dart';
import '../Endpoints/product_service.dart';
import '../constant.dart';
import '../models/product_createRequest.dart';
import '../models/products_module.dart';

class SystemAdminDashboard extends StatefulWidget {
  const SystemAdminDashboard({super.key});

  @override
  State<SystemAdminDashboard> createState() => _SystemAdminDashboardState();
}

class _SystemAdminDashboardState extends State<SystemAdminDashboard>
    with SingleTickerProviderStateMixin {
  final ProductService _productService = ProductService();
  final Categoryapi _categoryApi = Categoryapi();
  final Logger _logger = Logger();

  List<Category> _categories = [];
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  bool _isLoading = true;
  bool _isUploading = false;
  String? _errorMessage;
  File? _imageFile;
  Product? _editingProduct;
  String? selectedCategoryId;
  double _uploadProgress = 0;
  String _searchQuery = '';

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _ratingController = TextEditingController();
  final _searchController = TextEditingController();
  
  static const String _ownerId = "7ddbeb1a-9b61-493a-8c29-f90eee1c4287";

  // Modern UI Constants
  static const double _cardElevation = 2.0;
  static const double _cardBorderRadius = 16.0;
  static const double _imageSize = 60.0;
  static const EdgeInsets _defaultPadding = EdgeInsets.all(16.0);
  static const EdgeInsets _cardPadding = EdgeInsets.all(12.0);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _loadInitialData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _ratingController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    
    try {
      await Future.wait([
        _loadProducts(),
        _loadCategories(),
      ]);
      _animationController.forward();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data. Please try again.';
      });
      _logger.e('Error loading initial data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _categoryApi.fetchCategory();
      setState(() {
        _categories = categories;
        if (selectedCategoryId == null && categories.isNotEmpty) {
          selectedCategoryId = categories.first.id;
        }
      });
    } catch (e) {
      _showErrorToast('Failed to load categories');
      _logger.e('Error loading categories: $e');
    }
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productService.getProducts();
      setState(() {
        _products = products;
        _filteredProducts = products;
      });
    } catch (e) {
      _showErrorToast('Failed to load products');
      _logger.e('Error loading products: $e');
      rethrow;
    }
  }

  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredProducts = _products;
      } else {
        _filteredProducts = _products.where((product) {
          return product.product.toLowerCase().contains(query.toLowerCase()) ||
              _getCategoryName(product.category).toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  String _getCategoryName(String categoryId) {
    return _categories
        .firstWhere(
          (category) => category.id == categoryId,
          orElse: () => Category(id: categoryId, name: 'Unknown'),
        )
        .name;
  }

  

  Future<void> _pickImage() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      _showErrorToast('Failed to pick image');
      _logger.e('Error picking image: $e');
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0;
    });

    try {
      String? imageUrl;

      // Always require an image for product creation
      if (_editingProduct == null) {
        if (_imageFile == null) {
          throw Exception('Product image is required');
        }
        imageUrl = await _uploadImage(_imageFile!);
      } else {
        // For update: upload new image if picked, else use existing
        if (_imageFile != null) {
          imageUrl = await _uploadImage(_imageFile!);
        } else {
          imageUrl = _editingProduct!.imageUrl;
        }
      }

      final productRequest = ProductCreateRequest(
        id: _editingProduct?.id,
        name: _nameController.text.trim(),
        quantity: int.parse(_quantityController.text),
        price: double.parse(_priceController.text),
        categoryId: selectedCategoryId ?? _categories.first.id,
        ownerId: _ownerId,
        filePath: imageUrl,
      );

      if (_editingProduct == null) {
        await _productService.createProduct(productRequest);
        _showSuccessSnackbar('Product created successfully');
      } else {
        await _productService.updateProduct(Product(
          id: _editingProduct!.id,
          product: _nameController.text.trim(),
          unitPrice: double.parse(_priceController.text),
          imageUrl: imageUrl ?? '',
          category: selectedCategoryId ?? _categories.first.id,
          isApproved: _editingProduct!.isApproved,
          quantity: int.parse(_quantityController.text),
          rating: double.parse(_ratingController.text),
        ));
        _showSuccessSnackbar('Product updated successfully');
      }

      _resetForm();
      await _loadProducts();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      _showErrorSnackbar('Failed to save product: ${e.toString()}');
      _logger.e('Error submitting form: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    try {
      setState(() => _uploadProgress = 0.1);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://grocex-api.onrender.com/api/v1/products/upload'),
      );

      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      setState(() => _uploadProgress = 0.3);

      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: path.basename(imageFile.path),
        contentType: MediaType('image', path.extension(imageFile.path).substring(1)),
      );

      request.files.add(multipartFile);

      setState(() => _uploadProgress = 0.7);

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() => _uploadProgress = 1.0);
        _logger.i("Image uploaded successfully: ${responseData['imageUrl']}");
        return responseData['imageUrl'] ?? '';
      } else {
        _logger.e("Image upload failed with status: ${response.statusCode}");
        throw Exception('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      _logger.e('Image upload error: $e');
      throw Exception('Image upload failed: ${e.toString()}');
    }
  }

  void _editProduct(Product product) {
    setState(() {
      _editingProduct = product;
      _nameController.text = product.product;
      _priceController.text = product.unitPrice.toString();
      selectedCategoryId = _categories.any((c) => c.id == product.category)
          ? product.category
          : _categories.isNotEmpty ? _categories.first.id : null;
      _quantityController.text = product.quantity.toString();
      _ratingController.text = product.rating.toString();
      _imageFile = null;
    });
    _openFormModal();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _priceController.clear();
    _quantityController.clear();
    _ratingController.clear();
    setState(() {
      _imageFile = null;
      _editingProduct = null;
      _uploadProgress = 0;
      selectedCategoryId = null;
    });
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red[400],
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
      fontSize: 14.0,
    );
  }

  void _showErrorSnackbar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red[400],
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green[400],
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Future<bool> _confirmDeleteDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_cardBorderRadius),
            ),
            title: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange),
                SizedBox(width: 8),
                Text('Delete Product'),
              ],
            ),
            content: const Text(
              'Are you sure you want to delete this product? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _filterProducts,
        decoration: InputDecoration(
          hintText: 'Search products or categories...',
          prefixIcon: Icon(Icons.search, color: colors),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterProducts('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_cardBorderRadius),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    final totalProducts = _products.length;
    final approvedProducts = _products.where((p) => p.isApproved).length;
    final outOfStock = _products.where((p) => p.quantity <= 0).length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: _cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cardBorderRadius),
        ),
        child: Padding(
          padding: _cardPadding,
          child: Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Total Products',
                  totalProducts.toString(),
                  Icons.inventory,
                  colors,
                ),
              ),
              Container(width: 1, height: 40, color: Colors.grey[300]),
              Expanded(
                child: _buildStatItem(
                  'Approved',
                  approvedProducts.toString(),
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
              Container(width: 1, height: 40, color: Colors.grey[300]),
              Expanded(
                child: _buildStatItem(
                  'Out of Stock',
                  outOfStock.toString(),
                  Icons.warning,
                  Colors.orange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProductCard(Product product) {
    final categoryName = _getCategoryName(product.category);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardBorderRadius),
      ),
      elevation: _cardElevation,
      child: InkWell(
        borderRadius: BorderRadius.circular(_cardBorderRadius),
        onTap: () => _editProduct(product),
        child: Padding(
          padding: _cardPadding,
          child: Row(
            children: [
              _buildProductImage(product),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.product,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    _buildProductInfo(product, categoryName),
                  ],
                ),
              ),
              _buildActionButtons(product),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo(Product product, String categoryName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          categoryName,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '\$${product.unitPrice.toStringAsFixed(2)}',
          style: TextStyle(
            color: colors,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: product.quantity > 0 ? Colors.blue[50] : Colors.red[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                product.quantity > 0 ? 'Stock: ${product.quantity}' : 'Out of Stock',
                style: TextStyle(
                  color: product.quantity > 0 ? Colors.blue : Colors.red,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (product.rating > 0) ...[
              const SizedBox(width: 8),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber[600], size: 14),
                  Text(
                    ' ${product.rating.toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildProductImage(Product product) {
    return Hero(
      tag: 'product_${product.id}',
      child: Container(
        width: _imageSize,
        height: _imageSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: product.imageUrl.isNotEmpty
              ? Image.network(
                  product.imageUrl,
                  width: _imageSize,
                  height: _imageSize,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[100],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[100],
                    child: Icon(Icons.broken_image, color: Colors.grey[400]),
                  ),
                )
              : Container(
                  color: Colors.grey[100],
                  child: Icon(Icons.image, color: Colors.grey[400]),
                ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(Product product) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: product.isApproved ? Colors.green[50] : Colors.orange[50],
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: Icon(
              product.isApproved ? Icons.check_circle : Icons.pending,
              color: product.isApproved ? Colors.green : Colors.orange,
              size: 20,
            ),
            onPressed: () => _toggleProductApproval(product),
            tooltip: product.isApproved ? 'Approved' : 'Pending Approval',
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red[400], size: 20),
          onPressed: () => _deleteProduct(product),
          tooltip: 'Delete Product',
        ),
      ],
    );
  }

  Future<void> _toggleProductApproval(Product product) async {
    try {
      await _productService.approveProduct(product.id);
      await _loadProducts();
      _showSuccessSnackbar('Product approval status updated');
    } catch (e) {
      _showErrorSnackbar('Failed to update approval status');
      _logger.e('Error updating approval status: $e');
    }
  }

  Future<void> _deleteProduct(Product product) async {
    if (await _confirmDeleteDialog()) {
      try {
        await _productService.deleteProduct(product);
        await _loadProducts();
        _showSuccessSnackbar('Product deleted successfully');
      } catch (e) {
        _showErrorSnackbar('Failed to delete product');
        _logger.e('Error deleting product: $e');
      }
    }
  }

  void _openFormModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: ProductFormModal(
          formKey: _formKey,
          nameController: _nameController,
          priceController: _priceController,
          quantityController: _quantityController,
          ratingController: _ratingController,
          categories: _categories,
          selectedCategoryId: selectedCategoryId,
          onCategoryChanged: (val) => setState(() => selectedCategoryId = val),
          imageFile: _imageFile,
          onPickImage: _pickImage,
          isUploading: _isUploading,
          uploadProgress: _uploadProgress,
          onCancel: () {
            _resetForm();
            Navigator.pop(context);
          },
          onSubmit: _submitForm,
          isEdit: _editingProduct != null,
          currentImageName: _editingProduct?.imageUrl.isNotEmpty ?? false
              ? "Current image will be used"
              : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: colors,
        foregroundColor: Colors.white,
        title: const Text(
          'Product Dashboard',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadInitialData,
            tooltip: 'Refresh',
          ),
        ],
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _resetForm();
          _openFormModal();
        },
        backgroundColor: colors,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading products...'),
                ],
              ),
            )
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Colors.red[400],
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadInitialData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      _buildStatsCard(),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _filteredProducts.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _searchQuery.isNotEmpty
                                          ? Icons.search_off
                                          : Icons.inventory_2_outlined,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      _searchQuery.isNotEmpty
                                          ? 'No products found for "$_searchQuery"'
                                          : 'No products available',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: _loadInitialData,
                                color: colors,
                                child: ListView.builder(
                                  padding: const EdgeInsets.only(bottom: 80),
                                  itemCount: _filteredProducts.length,
                                  itemBuilder: (context, index) =>
                                      _buildProductCard(_filteredProducts[index]),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
    );
  }
}