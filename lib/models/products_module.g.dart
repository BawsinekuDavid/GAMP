// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      quantity: fields[7] as int,
      id: fields[0] as String,
      product: fields[1] as String,
      unitPrice: fields[3] as double,
      imageUrl: fields[4] as String,
      category: fields[5] as String,
      rating: fields[6] as double,
      isApproved: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.product)
      ..writeByte(3)
      ..write(obj.unitPrice)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.quantity)
      ..writeByte(8)
      ..write(obj.isApproved);
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
