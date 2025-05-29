import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';

class CartContainers extends StatelessWidget {
  final String name;
  final int quantity;
  final double unitPrice;
  final Widget? icon;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onRemove;

  const CartContainers({
    super.key,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    this.icon,
    this.onIncrement,
    this.onDecrement,
    this.onRemove,  
  });

  @override
  Widget build(BuildContext context) {
    final totalPrice = unitPrice * quantity;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: icon ?? const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'GHC ${unitPrice.toStringAsFixed(2)} × $quantity',
              style: TextStyle(color: Colors.grey[600]),
            ),
            Text(
              'Total: GHC ${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Decrement button
            IconButton(
              icon: const Icon(Icons.remove, size: 20),
              color: colors,
              onPressed: onDecrement,
            ),
            // Quantity display
            Text(
              quantity.toString(),
              style: const TextStyle(fontSize: 16),
            ),
            // Increment button
            IconButton(
              icon: const Icon(Icons.add, size: 20),
              color: colors,
              onPressed: onIncrement,
            ),
            // Remove button
            if (onRemove != null)
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                color: Colors.red[400],
                onPressed: onRemove,
              ),
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}