import 'package:flutter/material.dart';
import 'package:gmarket_app/components/order_containers.dart';

class OrdersPage extends StatelessWidget {
  final List _orders = [
    "order 1",
    "order 2",
    "order 3",
    'order 4',
    "order 5",
    "order 6"
  ];
   OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Your Orders",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body:  ListView.builder(itemCount:_orders.length, itemBuilder: (context, index) {
        return  Ordercontainers(
              imagePath: "lib/images/mangos.jpg",
              titletext: 'SeaDelights',
              subtitletext: '1x 1kg chicken',
              trailingtext: 'Ongoing',
              nametext: 'Locally brewed',
              dateTime: DateTime.now(),
              
            );
      },)
    );
  }
}
