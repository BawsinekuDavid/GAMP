import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order_module.dart';

class OrderContainer extends StatelessWidget {
  final Order order;
  final VoidCallback onTap;
  final bool showDetailsButton;

  const OrderContainer({
    super.key,
    required this.order,
    required this.onTap,
    this.showDetailsButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM dd, yyyy - hh:mm a').format(order.createdAt);
    final statusColor = _getStatusColor(order.status);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Product image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  order.imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Main content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name & Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            order.product,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            order.status.toUpperCase(),
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),
                    Text(
                      'Vendor: ${order.vendor}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),

                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoText('Qty', order.quantity),
                        _infoText('Items', order.items.length.toString()),
                        _infoText('Date', formattedDate),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'GHC ${order.totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (showDetailsButton)
                          TextButton(
                            onPressed: onTap,
                            child: const Text('Details'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoText(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return Colors.orange;
      case 'shipped':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }
}
