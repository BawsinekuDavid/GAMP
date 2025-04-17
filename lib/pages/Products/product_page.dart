import 'package:hive/hive.dart';

 

@HiveType(typeId: 0)
class Product extends HiveObject {
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
  final double rating;

  Product({
    this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.rating,
    required this.price,
    this.quantity = 1,
  });

  // Convert to Map (useful for other database operations)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'category': category,
      'rating': rating,
      'price': price,
      'quantity': quantity,
    };
  }

  // Create from Map (useful for other database operations)
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      category: map['category'],
      rating: map['rating'],
      price: map['price'],
      quantity: map['quantity'] ?? 1,
    );
  }

  // Helper method to create a copy with updated quantity
  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      image: image,
      name: name,
      category: category,
      rating: rating,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}