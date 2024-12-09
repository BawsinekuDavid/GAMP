import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';

// ignore: must_be_immutable
class DisplayContainer extends StatelessWidget {
  final String imagePath;
  final double numberRate;
  final String names;
  final Color containerText;

  // Constructor
  const DisplayContainer({
    super.key,
    required this.imagePath,
    required this.containerText,
    required this.numberRate,
    required this.names,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 190,
        height:150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200, // Background color for the container
        ),
        child: Stack(
          children: [
            // The image fills the entire container
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover, // Ensures the image covers the container
              ),
            ),
            // Text positioned at the bottom
        
          ],
        ),
    
      ),

      
    );
    
  }
}
