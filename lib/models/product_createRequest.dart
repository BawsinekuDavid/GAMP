class ProductCreateRequest {
  final String name;
  final int quantity;
  final double price;
  final String categoryId;
  final String ownerId;
  final String? id; // Optional, for update
  late final String? filePath; // Local file path for image
 final String? imageUrl; // Name of the current image if updating

  ProductCreateRequest({
    required this.name,
    required this.quantity,
    required this.price,
    required this.categoryId,
    required this.ownerId,
    this.id,
    this.filePath,
    this.imageUrl,
  });
}
