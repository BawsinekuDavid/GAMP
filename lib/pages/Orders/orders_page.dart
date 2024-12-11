import 'package:flutter/material.dart';

import '../../constant.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: colors,
      body: const Center(child: Text("ORDERS")),
    );
  }
}