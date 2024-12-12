import 'package:flutter/material.dart';
import 'package:gmarket_app/components/order_containers.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Ordercontainers(
              imagePath: "lib/images/mangos.jpg",
              titletext: 'SeaDelights',
              subtitletext: '1x 1kg chicken',
              trailingtext: 'Ongoing',
              nametext: 'Locally brewed',
              dateTime: DateTime.now(),
            ),
            const SizedBox(height: 40),
            Ordercontainers(
              imagePath: "lib/images/mangos.jpg",
              titletext: 'Barley',
              subtitletext: '1x 1kg chicken',
              trailingtext: 'Ghc 25.00',
              nametext: 'Exotic Breed',
              dateTime: DateTime.now(),
            ),
            const SizedBox(height: 40),
            Ordercontainers(
              imagePath: "lib/images/mangos.jpg",
              titletext: 'BerryBox',
              subtitletext: '1x 1kg chicken',
              trailingtext: 'Ghc 25.00',
              nametext: 'Mixed',
              dateTime: DateTime.now(),
            ),
            const SizedBox(height: 40),
            Ordercontainers(
              imagePath: "lib/images/mangos.jpg",
              titletext: 'ZenFruits',
              subtitletext: '1x 1kg chicken',
              trailingtext: 'Ghc 25.00',
              nametext: 'Fresh',
              dateTime: DateTime.now(),
            ),
          ],
        ),
      ),
    );
  }
}
