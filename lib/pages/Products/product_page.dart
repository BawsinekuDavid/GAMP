
class Product {
  final int id;
  final String image;
  final String name;
  final String category;

 double rating;

  Product({
    required this.id,
    required this.image,
    required this.name,
    required this.category,
    required this.rating,
  });

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'image': image,
      'name': name,
      'category': category,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic>map){
    return Product(id: map['id'],
     image: map['image'],
      name: map['name'], 
      category: map['category'],
       rating: map['rating']
       );
  }
}
