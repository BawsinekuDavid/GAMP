
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../PROVIDERS/ordersProvider.dart';
import '../../components/order_containers.dart';
import '../../constant.dart';

class OrdersPage extends StatefulWidget {
  final String userId;
  const OrdersPage({super.key, required this.userId});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    // Initialize the provider when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
      ordersProvider.fetchAndSetOrders(refresh: true);
    });
  }

  Future<void> _refreshOrders() async {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    await ordersProvider.fetchAndSetOrders(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        automaticallyImplyLeading: true,
        backgroundColor: colors,
        foregroundColor: Colors.white,
      ),
      body: _buildBody(ordersProvider),
    );
  }

  Widget _buildBody(OrdersProvider ordersProvider) {
    if (ordersProvider.isLoading && ordersProvider.orders.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (ordersProvider.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error loading orders\n${ordersProvider.error}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshOrders,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (ordersProvider.orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag_outlined,
                size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No orders yet',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshOrders,
              child: const Text('Refresh'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshOrders,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        itemCount: ordersProvider.orders.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final order = ordersProvider.orders[index];
          return OrderContainer(
            order: order,
            onTap: () {
              // Add navigation to order details if needed
            },
          );
        },
      ),
    );
  }
}