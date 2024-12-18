import 'package:hive/hive.dart';

class Product {
  final String name;
  final String image;
  final int quantity;
  final double price;
  final String category;
  final double rating;

  Product({
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.category,
    required this.rating,
  });
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    return Product(
      name: reader.readString(),
      image: reader.readString(),
      quantity: reader.readInt(),
      price: reader.readDouble(),
      category: reader.readString(),
      rating: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.image);
    writer.writeInt(obj.quantity);
    writer.writeDouble(obj.price);
    writer.writeString(obj.category); // Added category
    writer.writeDouble(obj.rating);  // Added rating
  }
}
