// components/order_containers.dart
import 'package:flutter/material.dart';

class Ordercontainers extends StatelessWidget {
  final String imagePath;
  final String titletext;
  final String subtitletext;
  final String trailingtext;
  final String nametext;
  final DateTime dateTime;
  final String orderId;
  final String vendorName;
  final String currentStatus;
  final VoidCallback onTap;

  const Ordercontainers({
    super.key,
    required this.imagePath,
    required this.titletext,
    required this.subtitletext,
    required this.trailingtext,
    required this.nametext,
    required this.dateTime,
    required this.orderId,
    required this.vendorName,
    required this.currentStatus,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titletext,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(subtitletext),
                    Text(nametext),
                    Text(
                      '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Chip(
                label: Text(trailingtext),
                backgroundColor: trailingtext == 'Processing'
                    ? Colors.orange[100]
                    : Colors.green[100],
                labelStyle: TextStyle(
                  color: trailingtext == 'Processing'
                      ? Colors.orange[800]
                      : Colors.green[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}