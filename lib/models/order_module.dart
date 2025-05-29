// orders_class.dart
import 'package:hive/hive.dart';

part 'order_module.g.dart';

@HiveType(typeId: 0)
class Order {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double unitPrice;

  @HiveField(2)
  final String quantity;

  @HiveField(3)
  final double totalPrice;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final DateTime createdAt;

  @HiveField(6)
  final String product;

  @HiveField(7)
  final String imageUrl;

  @HiveField(8)
  final String vendor;

  @HiveField(9)
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.product,
    required this.quantity,
    required this.imageUrl,
    required this.vendor,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    required this.items,
    required this.unitPrice,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      product: json['product'] ?? '',
      quantity: json['quantity']?.toString() ?? '',
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      unitPrice: (json['unitPrice'] as num?)?.toDouble() ?? 0.0,
      status: json['status']?.toString() ?? 'PENDING',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e))
              .toList() ??
          [],
      imageUrl: json['imageUrl'] ?? '',
      vendor: json['vendor'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
          'id': id,
        'product': product,
        'quantity': quantity,
        'totalPrice': totalPrice,
        'unitPrice': unitPrice,
        'status': status,
        'createdAt': createdAt.toIso8601String(),
        'items': items.map((item) => item.toJson()).toList(),
        'vendor': vendor,
        'imageUrl': imageUrl,
      };
}

@HiveType(typeId: 1)
class OrderItem {
  @HiveField(0)
  final String productId;
 
  @HiveField(2)
  final String customerId;

  @HiveField(3)
  final int quantity;

  OrderItem({
    required this.productId,
    required this.customerId,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId']?.toString() ?? '',
      customerId: json['customerId']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'customerId': customerId,
        'quantity': quantity,
      };
}
