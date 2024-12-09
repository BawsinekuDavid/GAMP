import 'package:flutter/material.dart';

class BottomIcons extends StatelessWidget {
  const BottomIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.home),
                    Icon(Icons.flash_auto_sharp),
                     
                    Icon(Icons.shopping_cart),
                    Icon(Icons.shopping_bag),
                    
                    Icon(Icons.person)
                  ],
                );
  }
}