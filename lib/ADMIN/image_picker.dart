//  import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePicker extends StatelessWidget {
//   const ImagePicker({super.key});

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
// @override


//   Widget _buildImagePicker() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Product Image', style: TextStyle(fontSize: 16)),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             ElevatedButton.icon(
//               onPressed: _pickImage,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               icon: const Icon(Icons.image, color: Colors.white),
//               label: const Text('Pick Image',
//                   style: TextStyle(color: Colors.white)),
//             ),
//             const SizedBox(width: 16),
//             if (_imageFile != null)
//               Expanded(
//                 child: Text(
//                   _imageFile!.path.split('/').last,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               )
//             else if (_editingProduct?.imageUrl.isNotEmpty ?? false)
//               const Expanded(
//                 child: Text("Current image will be used"),
//               ),
//           ],
//         ),
//       ],
//     );
//   }
  
  
// }