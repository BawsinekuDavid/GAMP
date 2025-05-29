class Vendor {
  final String id;
  final String name;
  final String? status;
  final String? location;

  Vendor({
    required this.id,
    required this.name,
    this.location,
    this.status,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
        id: json['_id'] ?? json['id'] ?? '',
        name: json['name'] ?? 'Unknown Vendor',
        location: json['location'],
        status: json['status'] 
        );
  }
}
