// product_model.dart

import 'package:hive_flutter/hive_flutter.dart';

part 'products_module.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String product;

  @HiveField(3)
  final double unitPrice;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  final String category;

  @HiveField(6)
  final double rating;

  @HiveField(7)
  int quantity;

  @HiveField(8)
  final bool isApproved;
  Product({
    required this.quantity,
    required this.id,
    required this.product,
    required this.unitPrice,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.isApproved,
    g,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        product: json['product'] ?? 'no name',
        unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
        imageUrl: json['imageUrl'] ?? json['imageurl'] ?? '',
        category: json['category'] ?? '',
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        quantity: json['quantity'] ?? '',
        isApproved: json['isApproved'] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': product,
      'price': unitPrice,
      'imageUrl': imageUrl,
      'category': category,
      'quantity': quantity,
      'isApproved': isApproved,
    };
  }

  delete() {}

  int copyWith({required int quantity}) {
    return quantity; 
  }
     
   
}
