
class Product {
  final int? id;
  final String image;
  final String name;
  final String category;

 double rating;

  Product({
    this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.rating, required int quantity, required double price,
  });
}