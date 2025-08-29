import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ModernProductImagePicker extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;
  final Function(File) onImagePicked;
  final String? currentImageName;
  final int uploadProgress;
  final bool isUploading;

  const ModernProductImagePicker({
    super.key,
    this.imageFile,
    this.imageUrl,
    required this.onImagePicked,
    this.currentImageName,
    this.uploadProgress = 0,
    this.isUploading = false,
  }) : assert(uploadProgress >= 0 && uploadProgress <= 100);

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1200,
      );
      if (pickedFile != null) {
        onImagePicked(File(pickedFile.path));
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Icon(Icons.image, color: primaryColor, size: 20),
              const SizedBox(width: 8),
              const Text("Product Image",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const Spacer(),
              if (uploadProgress > 0 && uploadProgress < 100)
                _progressBadge(),
              if (isUploading)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(primaryColor),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Preview if available
          if (imageFile != null || imageUrl != null || currentImageName != null)
            _preview(primaryColor),

          const SizedBox(height: 12),

          // Pick button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: isUploading ? null : _pickImage,
              icon: const Icon(Icons.add_photo_alternate, size: 20),
              label: Text(
                (imageFile != null || imageUrl != null)
                    ? "Change Image"
                    : "Select Image",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),

          if (isUploading) ...[
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: uploadProgress / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(primaryColor),
              minHeight: 4,
            ),
          ]
        ],
      ),
    );
  }

  /// Small badge showing % progress
  Widget _progressBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text("$uploadProgress%",
          style: TextStyle(
              color: Colors.blue[700],
              fontSize: 12,
              fontWeight: FontWeight.w600)),
    );
  }

  /// Preview row
  Widget _preview(Color primaryColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          _imageContainer(),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _imageName(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          if (imageFile != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(12)),
              child: Text("NEW",
                  style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 10,
                      fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }

  /// Thumbnail
  Widget _imageContainer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 50,
        height: 50,
        child: _imageWidget(),
      ),
    );
  }

  Widget _imageWidget() {
    if (imageFile != null) {
      return Image.file(imageFile!, fit: BoxFit.cover);
    } else if (imageUrl != null) {
      return Image.network(imageUrl!, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _placeholder());
    }
    return _placeholder();
  }

  Widget _placeholder() =>
      Icon(Icons.image, color: Colors.grey[400], size: 24);

  String _imageName() {
    if (imageFile != null) return imageFile!.path.split('/').last;
    if (imageUrl != null) return imageUrl!.split('/').last;
    return currentImageName ?? "No image selected";
  }
}
