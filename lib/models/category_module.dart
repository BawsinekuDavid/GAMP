class Category {
  final String id;
  final String name;

  Category({
    required this.id,
     required this.name
     });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? json['id'] ?? '', // Handle both '_id' and 'id'
      name: json['name'] ?? '',
    );
  }
}
