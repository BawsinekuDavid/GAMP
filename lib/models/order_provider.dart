// orders_provider.dart
import 'package:flutter/foundation.dart';
import 'package:gmarket_app/pages/Products/product_page.dart';

class Order {
  final String id;
  final List<Product> items;
  final double total;
  final DateTime date;
  final String address;
  final String contact;
  final String paymentMethod;
  final bool isDelivery;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.date,
    required this.address,
    required this.contact,
    required this.paymentMethod,
    required this.isDelivery,
  });
}

class OrdersProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(Order order) {
    _orders.insert(0, order);
    notifyListeners();
  }
}