import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmarket_app/models/category_module.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'dart:io';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../Endpoints/categoryapi.dart';
import '../Endpoints/product_service.dart';
import '../constant.dart';
import '../models/products_module.dart';

class SystemAdminDashboard extends StatefulWidget {
  const SystemAdminDashboard({super.key});

  @override
  State<SystemAdminDashboard> createState() => _SystemAdminDashboardState();
}

class _SystemAdminDashboardState extends State<SystemAdminDashboard> {
  // Services
  final ProductService _productService = ProductService();
  final Categoryapi _categoryApi = Categoryapi();

  // State variables
  List<Category> _categories = [];
  List<Product> _products = [];

  bool _isLoading = true;
  bool _isUploading = false;
  String? _errorMessage;
  File? _imageFile;
  Product? _editingProduct;
  String? selectedCategoryId;
  double _uploadProgress = 0;

  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _ratingController = TextEditingController();

  // Constants
  static const double _cardElevation = 4.0;
  static const double _cardBorderRadius = 12.0;
  static const double _imageSize = 50.0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _loadCategories();
    _loadProducts();
  }

  Future<void> _loadInitialData() async {
    setState(() {
   
    });
    try {
      await Future.wait([
        _loadProducts(),
        _loadCategories(),
      ]);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
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
      _showErrorSnackbar('Failed to load categories: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _productService.getProducts();
      setState(() {
        _products = products;
      });
    } catch (e) {
      _showErrorSnackbar('Failed to load products: ${e.toString()}');
      rethrow; // Re-throw to be caught in _loadInitialData
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isUploading = true;
      _uploadProgress = 0;
    });

    try {
      String imageUrl = _editingProduct?.imageUrl ?? '';

      // Upload new image if selected
      if (_imageFile != null) {
        imageUrl = await _uploadImage(_imageFile!);
      }

      final product = Product(
        id: _editingProduct?.id ?? '',
        product: _nameController.text,
        unitPrice: double.parse(_priceController.text),
        imageUrl: imageUrl,
        category: selectedCategoryId ?? _categories.first.id,
        isApproved: _editingProduct?.isApproved ?? false,
        quantity: int.parse(_quantityController.text),
        rating: double.parse(_ratingController.text),
      );

      if (_editingProduct == null) {
        await _productService.createProduct(product);
        _showSuccessSnackbar('Product created successfully');
        Navigator.pop(context);
      } else {
        await _productService.updateProduct(product);
        _showSuccessSnackbar('Product updated successfully');
         Navigator.pop(context);
      }

      _resetForm();
      await _loadProducts();
      if (mounted) Navigator.pop(context);
    } catch (e) {
      _showErrorSnackbar('Failed to save product: ${e.toString()}');
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
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://grocex-api.onrender.com/api/v1/products/upload'),
      );

      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: path.basename(imageFile.path),
        contentType: MediaType('image', path.extension(imageFile.path).substring(1)),
      );

      request.files.add(multipartFile);

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['imageUrl'] ?? '';
      } else {
        throw Exception('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
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
        : _categories.first.id;
      _quantityController.text = product.quantity.toString();
      _ratingController.text = product.rating.toString();
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
    });
  }

  void _showErrorSnackbar(String message) {
    Fluttertoast. showToast(msg: "failed to upload product");

  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<bool> _confirmDeleteDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Product'),
            content: const Text('Are you sure you want to delete this product?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _buildProductCard(Product product) {
    String categoryName = _categories
        .firstWhere(
          (category) => category.id == product.category,
          orElse: () => Category(id: product.id, name:product.category),
        )
        .name;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardBorderRadius),
      ),
      elevation: _cardElevation,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: _buildProductImage(product),
        title: Text(
          product.product,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(categoryName),
            Text(
              '\$${product.unitPrice.toStringAsFixed(2)}',
              style: const TextStyle(color: Colors.green),
            ),
            if (product.quantity > 0)
              Text('In stock: ${product.quantity}',
                  style: const TextStyle(color: Colors.blue))
            else
              const Text('Out of stock', style: TextStyle(color: Colors.red)),
            if (product.rating > 0)
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  Text(' ${product.rating.toStringAsFixed(1)}'),
                ],
              ),
          ],
        ),
        trailing: _buildActionButtons(product),
      ),
    );
  }

  Widget _buildProductImage(Product product) {
    return product.imageUrl.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.imageUrl,
              width: _imageSize,
              height: _imageSize,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, color: Colors.grey),
            ),
          )
        : Container(
            width: _imageSize,
            height: _imageSize,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.image, color: Colors.grey),
          );
  }

  Widget _buildActionButtons(Product product) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            product.isApproved ? Icons.check_circle : Icons.pending,
            color: product.isApproved ? Colors.green : Colors.orange,
          ),
          onPressed: () async {
            try {
              await _productService.approveProduct(product.id);
              await _loadProducts();
              _showSuccessSnackbar('Product approval status updated');
            } catch (e) {
              _showErrorSnackbar('Failed to update status: ${e.toString()}');
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.blue),
          onPressed: () => _editProduct(product),
        ),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            if (await _confirmDeleteDialog()) {
              try {
                await _productService.deleteProduct(product.id);
                await _loadProducts();
                _showSuccessSnackbar('Product deleted successfully');
              } catch (e) {
                _showErrorSnackbar('Failed to delete: ${e.toString()}');
              }
            }
          },
        ),
      ],
    );
  }
// In your _SystemAdminDashboardState class:

// Add this method to build the category dropdown
Widget _buildCategoryDropdown() {
  // Ensure we have categories to show
  if (_categories.isEmpty) {
    return const Text('No categories available');
  }

  return DropdownButtonFormField<String>(
    value: selectedCategoryId ?? _categories.first.id,
    onChanged: (String? newValue) {
      setState(() {
        selectedCategoryId = newValue;
      });
    },
    items: _categories.map<DropdownMenuItem<String>>((Category category) {
      return DropdownMenuItem<String>(
        value: category.id,
        child: Text(category.name),
      );
    }).toList(),
    decoration: const InputDecoration(
      labelText: 'Category',
      border: OutlineInputBorder(),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please select a category';
      }
      return null;
    },
  );
}

// Update your _buildFormFields to use the new dropdown
 
  Widget _buildFormFields() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) => value!.isEmpty ? 'Required' : null,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _priceController,
          decoration: const InputDecoration(
            labelText: 'Price',
            border: OutlineInputBorder(),
            prefixText: '\$ ',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value!.isEmpty) return 'Required';
            if (double.tryParse(value) == null) return 'Invalid number';
            if (double.parse(value) <= 0) return 'Must be greater than 0';
            return null;
          },
        ),
        const SizedBox(height: 16),
         _buildCategoryDropdown(),
        const SizedBox(height: 16),
        TextFormField(
          controller: _quantityController,
          decoration: const InputDecoration(
            labelText: 'Quantity',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) return 'Required';
            if (int.tryParse(value) == null) return 'Invalid number';
            if (int.parse(value) < 0) return 'Cannot be negative';
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _ratingController,
          decoration: const InputDecoration(
            labelText: 'Rating',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          validator: (value) {
            if (value!.isEmpty) return 'Required';
            if (double.tryParse(value) == null) return 'Invalid number';
            final rating = double.parse(value);
            if (rating < 0 || rating > 5) return 'Must be between 0 and 5';
            return null;
          },
        ),
        const SizedBox(height: 16),
        _buildImagePicker(),
        if (_isUploading) ...[
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: _uploadProgress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(colors),
          ),
          const SizedBox(height: 8),
          Text(
            'Uploading: ${(_uploadProgress * 100).toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ],
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Product Image', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.image, color: Colors.white),
              label: const Text('Pick Image',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(width: 16),
            if (_imageFile != null)
              Expanded(
                child: Text(
                  _imageFile!.path.split('/').last,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            else if (_editingProduct?.imageUrl.isNotEmpty ?? false)
              const Expanded(
                child: Text("Current image will be used"),
              ),
          ],
        ),
      ],
    );
  }

  void _openFormModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          left: 16,
          right: 16,
          top: 24,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _editingProduct == null ? 'Add Product' : 'Edit Product',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildFormFields(),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isUploading
                          ? null
                          : () {
                              _resetForm();
                              Navigator.pop(context);
                            },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(

                      onPressed:(){
                        _isUploading ? null : _submitForm;
                        Navigator.pop(context);
                      } ,
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      child: _isUploading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              _editingProduct == null
                                  ? 'Add Product'
                                  : 'Update Product',
                              style: const TextStyle(color: Colors.white),
                            ),
                            
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: colors,
        title: const Text('Product Dashboard',
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _loadInitialData,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _resetForm();
          _openFormModal();
        },
        backgroundColor: colors,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : _products.isEmpty
                  ? const Center(
                      child: Text(
                        'No products available',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _loadInitialData,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _products.length,
                        itemBuilder: (context, index) =>
                            _buildProductCard(_products[index]),
                      ),
                    ),
    );
  }
}