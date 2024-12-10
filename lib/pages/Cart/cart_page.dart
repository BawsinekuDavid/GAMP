import 'package:flutter/material.dart';

import '../../constant.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors),
        title: Text("Delivery and Payment", style: TextStyle(color: colors),),
      ),
        
       );
       
    
  }
}