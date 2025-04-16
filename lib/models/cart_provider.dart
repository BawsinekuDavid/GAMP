import 'package:flutter/material.dart';

import 'package:gmarket_app/pages/Products/product_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../db/hiveService.dart';

class CartProvider extends ChangeNotifier {
  late final Box<Product> _cartBox;
  List<Product> _products = [];
  bool _isInitialized = false;
  bool _isInitializing = false;

  List<Product> get products => _products;
  bool get isReady => _isInitialized;

  Future<void> _ensureInitialized() async {
    if (_isInitialized) return;
    if (_isInitializing) {
      await Future.doWhile(() => !_isInitialized);
      return;
    }

    _isInitializing = true;
    try {
      _cartBox = await HiveService.openBox<Product>('cartbox');
      _products = _cartBox.values.toList();
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing cart box: $e');
      _isInitializing = false;
      rethrow;
    }
  }

  // Rest of your CartProvider methods remain the same...
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
        0.0, (total, product) => total + (product.price * product.quantity));
  }
}
