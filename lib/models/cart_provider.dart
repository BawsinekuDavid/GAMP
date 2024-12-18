import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:gmarket_app/pages/Products/product_page.dart';
class CartProvider extends ChangeNotifier {
  late Box<Product> _cartBox;
  List<Product> products = [];


  CartProvider() {
    initializeCart();
  }
  Future<void> initializeCart() async {
    // Access the already opened box
    _cartBox = Hive.box<Product>('cartbox');

    // Load products from the box if needed
    products = _cartBox.values.toList();
    notifyListeners();
  }

  void addToCart(Product product) {
    _cartBox.add(product);
    products.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartBox.delete(product.id);
    products.remove(product);
    notifyListeners();
  }

  double calculateTotal() {
    return products.fold(0.0, (total, product) => total + product.price);
  }
}

