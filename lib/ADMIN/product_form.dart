import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmarket_app/models/category_module.dart';
import 'image_picker.dart';
 

class ProductFormModal extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController quantityController;
  final TextEditingController ratingController;
  final List<Category> categories;
  final String? selectedCategoryId;
  final Function(String?) onCategoryChanged;
  final File? imageFile;
  final VoidCallback onPickImage;
  final bool isUploading;
  final double uploadProgress;
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final bool isEdit;
  final String? currentImageName;

  const ProductFormModal({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.priceController,
    required this.quantityController,
    required this.ratingController,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategoryChanged,
    required this.imageFile,
    required this.onPickImage,
    required this.isUploading,
    required this.uploadProgress,
    required this.onCancel,
    required this.onSubmit,
    required this.isEdit,
    this.currentImageName,
  });

  static const double _borderRadius = 16.0;
  static const EdgeInsets _fieldSpacing = EdgeInsets.symmetric(vertical: 8.0);
  static const EdgeInsets _contentPadding = EdgeInsets.all(20.0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_borderRadius * 1.25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          _buildHeader(context, primaryColor),
          
          // Form content
          Flexible(
            child: SingleChildScrollView(
              padding: _contentPadding,
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildNameField(),
                    _buildPriceField(),
                    _buildCategoryField(),
                    _buildQuantityField(),
                    _buildRatingField(),
                    const SizedBox(height: 16),
                    
                  //  _buildImagePicker(),
                    if (isUploading) _buildUploadProgress(),
                    const SizedBox(height: 32),
                    _buildActionButtons(context, primaryColor),
                    // Add bottom padding for safe area
                    SizedBox(height: MediaQuery.of(context).padding.bottom),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color primaryColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(_borderRadius * 1.25),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isEdit ? Icons.edit : Icons.add_box,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEdit ? 'Edit Product' : 'Add New Product',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  isEdit ? 'Update product information' : 'Create a new product listing',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Padding(
      padding: _fieldSpacing,
      child: TextFormField(
        controller: nameController,
        textCapitalization: TextCapitalization.words,
        decoration: _buildInputDecoration(
          label: 'Product Name',
          icon: Icons.shopping_bag,
          hint: 'Enter product name',
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Product name is required';
          }
          if (value.trim().length < 2) {
            return 'Name must be at least 2 characters';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPriceField() {
    return Padding(
      padding: _fieldSpacing,
      child: TextFormField(
        controller: priceController,
        decoration: _buildInputDecoration(
          label: 'Price',
          icon: Icons.attach_money,
          hint: '0.00',
          prefix: '\$ ',
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Price is required';
          }
          final price = double.tryParse(value);
          if (price == null) {
            return 'Please enter a valid number';
          }
          if (price <= 0) {
            return 'Price must be greater than 0';
          }
          if (price > 999999) {
            return 'Price is too high';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCategoryField() {
    return Padding(
      padding: _fieldSpacing,
      child: DropdownButtonFormField<String>(
        value: selectedCategoryId ?? (categories.isNotEmpty ? categories.first.id : null),
        onChanged: onCategoryChanged,
        decoration: _buildInputDecoration(
          label: 'Category',
          icon: Icons.category,
          hint: 'Select category',
        ),
        items: categories.map<DropdownMenuItem<String>>((Category category) {
          return DropdownMenuItem<String>(
            value: category.id,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(category.name),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(category.name)),
              ],
            ),
          );
        }).toList(),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a category';
          }
          return null;
        },
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
      ),
    );
  }

  Widget _buildQuantityField() {
    return Padding(
      padding: _fieldSpacing,
      child: TextFormField(
        controller: quantityController,
        decoration: _buildInputDecoration(
          label: 'Quantity',
          icon: Icons.inventory,
          hint: 'Available stock',
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Quantity is required';
          }
          final quantity = int.tryParse(value);
          if (quantity == null) {
            return 'Please enter a valid number';
          }
          if (quantity < 0) {
            return 'Quantity cannot be negative';
          }
          if (quantity > 999999) {
            return 'Quantity is too high';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildRatingField() {
    return Padding(
      padding: _fieldSpacing,
      child: TextFormField(
        controller: ratingController,
        decoration: _buildInputDecoration(
          label: 'Rating',
          icon: Icons.star,
          hint: '0.0 - 5.0',
          suffix: '/5.0',
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Rating is required';
          }
          final rating = double.tryParse(value);
          if (rating == null) {
            return 'Please enter a valid number';
          }
          if (rating < 0 || rating > 5) {
            return 'Rating must be between 0 and 5';
          }
          return null;
        },
      ),
    );
  }

// Widget _buildImagePicker() {
//   return ModernProductImagePicker(
//     imageFile: imageFile,
//     imageUrl: imageUrl,
//     currentImageName: currentImageName,
//     uploadProgress: uploadProgress,
//     isUploading: isUploading,
//     onImagePicked: (file) {
//       setState(() {
//         imageFile = file;
//       });
//     },
//   );
// }


  Widget _buildUploadProgress() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.cloud_upload, color: Colors.blue[600], size: 20),
              const SizedBox(width: 8),
              Text(
                'Uploading Image...',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '${(uploadProgress * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: uploadProgress,
            backgroundColor: Colors.blue[100],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
            minHeight: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Color primaryColor) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: OutlinedButton(
            onPressed: isUploading ? null : onCancel,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: Colors.grey[300]!),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: isUploading ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
            ),
            child: isUploading
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text('Processing...'),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(isEdit ? Icons.update : Icons.add),
                      const SizedBox(width: 8),
                      Text(
                        isEdit ? 'Update Product' : 'Create Product',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required IconData icon,
    String? hint,
    String? prefix,
    String? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, size: 20),
      prefixText: prefix,
      suffixText: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Color _getCategoryColor(String categoryName) {
    // Generate a consistent color based on category name
    final colors = [
      Colors.red[400]!,
      Colors.blue[400]!,
      Colors.green[400]!,
      Colors.orange[400]!,
      Colors.purple[400]!,
      Colors.teal[400]!,
      Colors.pink[400]!,
      Colors.indigo[400]!,
    ];
    return colors[categoryName.hashCode % colors.length];
  }
}