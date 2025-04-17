import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../pages/Products/product_page.dart';
 

class CartProvider with ChangeNotifier {
  late final Box<Product> _cartBox;
  List<Product> _products = [];
  bool _isInitialized = false;

  List<Product> get products => _products;
  bool get isReady => _isInitialized;

  Future<void> init() async {
    if (_isInitialized) return;
    
    _cartBox = await Hive.openBox<Product>('cart');
    _products = _cartBox.values.toList();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> addToCart(Product product) async {
    await init();
    
    final existingIndex = _products.indexWhere(
      (p) => p.name == product.name && p.price == product.price
    );

    if (existingIndex >= 0) {
      // Update quantity if product exists
      final existing = _products[existingIndex];
      await _cartBox.putAt(
        existingIndex,
        existing.copyWith(quantity: existing.quantity + product.quantity),
      );
    } else {
      // Add new product
      await _cartBox.add(product);
    }
    
    _products = _cartBox.values.toList();
    notifyListeners();
  }

  Future<void> updateQuantity(int index, int newQuantity) async {
    await init();
    
    if (newQuantity <= 0) {
      await removeFromCart(index);
      return;
    }

    final product = _products[index];
    await _cartBox.putAt(
      index,
      product.copyWith(quantity: newQuantity),
    );
    
    _products = _cartBox.values.toList();
    notifyListeners();
  }

  Future<void> removeFromCart(int index) async {
    await init();
    await _cartBox.deleteAt(index);
    _products = _cartBox.values.toList();
    notifyListeners();
  }

  Future<void> clearCart() async {
    await init();
    await _cartBox.clear();
    _products = [];
    notifyListeners();
  }

  double get totalPrice {
    return _products.fold(
      0.0,
      (total, product) => total + (product.price * product.quantity),
    );
  }

  int get itemCount {
    return _products.fold(
      0,
      (count, product) => count + product.quantity,
    );
  }
}