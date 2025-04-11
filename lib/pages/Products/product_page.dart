import 'package:hive_flutter/adapters.dart';

part 'product_page.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String image;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String category;
  
  @HiveField(4)
  final double price;

  @HiveField(5)
  int quantity;

  @HiveField(6)
  double rating;

  Product({
    this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.rating,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'category': category,
      'rating': rating,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        image: map['image'],
        name: map['name'],
        category: map['category'],
        rating: map['rating'],
        price: map['price']);
  }

  delete() {}

  // void removeFromCart(Product product) {}
}
