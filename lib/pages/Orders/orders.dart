import '../Products/product_page.dart';

class Order {
  final String id;
  final List<Product> products;
  final double total;
  final DateTime date;
  final String status;

  Order({
    required this.id,
    required this.products,
    required this.total,
    required this.date,
    required this.status,
  });
}
