import 'package:flutter/material.dart';
import 'package:gmarket_app/components/order_containers.dart';
import 'package:provider/provider.dart';
import '../../models/cart_provider.dart';
import 'track_order_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final orders = cartProvider.orders;

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
      body: orders.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list_alt, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    "No orders yet",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your orders will appear here.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final firstProduct = order.products.isNotEmpty 
                    ? order.products.first 
                    : null;
                
                return Ordercontainers(
                  imagePath: firstProduct?.image ?? "lib/images/mangos.jpg",
                  titletext: order.products.length > 1
                      ? "${firstProduct?.name ?? 'Order'} + ${order.products.length - 1} more"
                      : firstProduct?.name ?? 'Order',
                  subtitletext: '${order.products.length} items',
                  trailingtext: order.status,
                  nametext: 'Total: GHC ${order.total.toStringAsFixed(2)}',
                  dateTime: order.date,
                  orderId: order.id,
                  vendorName: "SeaDelights",
                  currentStatus: order.status,
                  onTap: () {
                    Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TrackOrderPage(
      orderId: "12345",
      vendorName: "Fresh Fruits Market",
      vendorImage: "https://example.com/vendor.jpg",
      currentStatus: "Preparing Order",
      deliveryAddress: "123 Main St, Accra",
      contactNumber: "+233 123 456 789",
      paymentMethod: "Mobile Money",
      totalAmount: "GHC 7.00",
      orderDate: DateTime.now(),
    ),
  ),
);
                  },
                );
              },
            ),
    );
  }
}