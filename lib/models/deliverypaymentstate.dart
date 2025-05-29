import 'package:flutter/material.dart';

class DeliveryPaymentState extends ChangeNotifier{
  String paymentMethod = "Cash";
  double subtotal = 5.00;
  double deliveryFee = 0.0;
  double discount = 0.0;
  String address = "234, Nii Ayiksi St";
  String contact = "+233 551015625";

  double calculateTotal() {
    return subtotal + deliveryFee - discount;
  }

  void applyDiscount(double amount) {
    discount = amount;
  }

  void resetDiscount() {
    discount = 0.0;
  }

  void setDeliveryFee(double fee) {
    deliveryFee = fee;
  }

  void updatePaymentMethod(String method) {
    paymentMethod = method;
  }

  void updateAddress(String newAddress) {
    address = newAddress;
  }

  void updateContact(String newContact) {
    contact = newContact;
  }
}