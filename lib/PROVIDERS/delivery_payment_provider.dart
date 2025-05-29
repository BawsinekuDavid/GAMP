// delivery_payment_provider.dart
import 'package:flutter/material.dart';

class DeliveryPaymentProvider with ChangeNotifier {
  double _deliveryFee = 5.00;
  double _discount = 0.0;
  String _selectedPaymentMethod = 'Cash on Delivery';

  double get deliveryFee => _deliveryFee;
  double get discount => _discount;
  String get selectedPaymentMethod => _selectedPaymentMethod;
  

  void updateDeliveryFee(double newFee) {
    _deliveryFee = newFee;
    notifyListeners();
  }

  void applyDiscount(double discountAmount) {
    _discount = discountAmount;
    notifyListeners();
  }

  void selectPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }
}