import 'package:flutter/material.dart';
import 'package:gmarket_app/pages/Products/product_page.dart';

class CartProvider with ChangeNotifier {
  final List <Product>_product = [];

  List <Product> get product => _product;

  void addToCart(Product item) {
    final index = _product.indexWhere((product)=> product.name ==item.name);
    if(index != -1){
        _product[index].quantity += item.quantity;
    }else{
      _product.add(item);
    }
    notifyListeners();
    
  }
  void removeFromCart(Product item) {
    _product.remove(item);
    notifyListeners();
  }
  void clearCart(){
    _product.clear();
    notifyListeners();
  }
}