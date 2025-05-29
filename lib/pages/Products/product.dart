import 'package:hive/hive.dart';

part 'product.g.dart'; // This is the generated file

@HiveType(typeId: 0)
class Product{
  @HiveField(0)
  final int? id;
  
  @HiveField(1)
  final String product;
  
 
  @HiveField(3)
  final double price;
  
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
    required this.id,
    required this.product,
     
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.rating,
    required this.quantity,
    required this.isApproved,
  });
}