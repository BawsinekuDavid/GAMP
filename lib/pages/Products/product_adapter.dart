import 'package:hive/hive.dart';

class Product {
  final String name;
  final String image;
  int quantity; // Changed to non-final for mutable quantity
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

  // Helper method to create a copy with updated quantity
  Product copyWith({
    String? name,
    String? image,
    int? quantity,
    double? price,
    String? category,
    double? rating,
  }) {
    return Product(
      name: name ?? this.name,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      category: category ?? this.category,
      rating: rating ?? this.rating,
    );
  }
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0; // Must be unique per adapter

  @override
  Product read(BinaryReader reader) {
    try {
      return Product(
        name: reader.readString(),
        image: reader.readString(),
        quantity: reader.readInt(),
        price: reader.readDouble(),
        category: reader.readString(),
        rating: reader.readDouble(),
      );
    } catch (e) {
      throw HiveError('Failed to read Product: $e');
    }
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    try {
      writer.writeString(obj.name);
      writer.writeString(obj.image);
      writer.writeInt(obj.quantity);
      writer.writeDouble(obj.price);
      writer.writeString(obj.category);
      writer.writeDouble(obj.rating);
    } catch (e) {
      throw HiveError('Failed to write Product: $e');
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}