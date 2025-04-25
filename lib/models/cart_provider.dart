import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:gmarket_app/pages/Products/product_page.dart';

import '../pages/Orders/orders.dart';

class CartProvider extends ChangeNotifier {
  late final Box<Product> _cartBox;
  List<Product> _products = [];
  bool _isInitialized = false;
  bool _isInitializing = false;

  var ensureInitialized;

  List<Product> get products => _products;
  bool get isReady => _isInitialized;

  final List<Order> _orders = [];
  
  List<Order> get orders => _orders;
  
  void checkout() {
    if (_products.isEmpty) return;
    
    final order = Order(
    id: DateTime.now().millisecondsSinceEpoch.toString(),
    products: List.from(_products),
    total: calculateTotal(),
    date: DateTime.now(),
     status: 'Pending',
  );
    
    _orders.add(order);
    _products.clear();
    notifyListeners();
  }

  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    if (_isInitializing) {
      // Wait if already initializing
      await Future.doWhile(() => !_isInitialized);
      return;
    }

    _isInitializing = true;
    try {
      // Check if the box is already open, open if not
      if (!Hive.isBoxOpen('cartbox')) {
        await Hive.openBox<Product>('cartbox');
      }

      _cartBox = Hive.box<Product>('cartbox');
      _products = _cartBox.values.toList();
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing cart box: $e');
      _isInitializing = false;
      rethrow;
    }
  }

  Future<void> addToCart(Product product) async {
    await _ensureInitialized();

    await _cartBox.add(product);
    _products = _cartBox.values.toList();
    notifyListeners();
  }

  Future<void> removeFromCart(Product product) async {
    await _ensureInitialized();

    await product.delete();
    _products = _cartBox.values.toList();
    notifyListeners();
  }

  Future<void> clearCart() async {
    await _ensureInitialized();

    await _cartBox.clear();
    _products = [];
    notifyListeners();
  }

  double calculateTotal() {
    return _products.fold(
      0.0,
      (total, product) => total + (product.price * product.quantity),
    );
  }

    void addOrder() {
    if (products.isEmpty) return;

    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      products: List<Product>.from(products),
      total: calculateTotal(),
      date: DateTime.now(),
      status: "Pending",
    );

    orders.add(newOrder);
    products.clear(); // clear the cart
    notifyListeners();
  }
}
