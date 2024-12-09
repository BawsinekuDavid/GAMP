import 'package:flutter/material.dart';

import '../../constant.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: colors,
      body: Center(child: Text("CART")),
    );
  }
}