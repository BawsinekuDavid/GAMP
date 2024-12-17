class Product {
  final int? id;
  final String image;
  final String name;
  final String category;
  final double price;
  int quantity;

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
      'price':price,
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

  void removeFromCart(Product product) {}
}
