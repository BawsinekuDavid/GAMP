import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/Vendors/vendors.dart';
import '../../models/vendors_module.dart';

class VendorCard extends StatelessWidget {
  final Vendor vendor;

  const VendorCard({
    super.key,
    required this.vendor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const VendorsSection()));
      },
      child: Container(
      width: 140,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vendor image or icon
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: const Center(
                  child: Icon(Icons.store_mall_directory, size: 28, color: Colors.grey),
                ),
              ),

              // Info section
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Vendor Name
                    Text(
                      vendor.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    

                    // Location
                    if (vendor.location != null && vendor.location!.isNotEmpty)
                      Row(
                        children: [
                       Icon(Icons.location_on, size: 14, color:colors ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              vendor.location!,
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      
                  ],
                ),
              ),
            ],
          ),

          // Top-right Status Badge
          if (vendor.status != null && vendor.status!.isNotEmpty)
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(vendor.status!),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_shouldShowStatusIcon(vendor.status!))
                      Icon(
                        _getStatusIcon(vendor.status!),
                        size: 12,
                        color: Colors.white,
                      ),
                    if (_shouldShowStatusIcon(vendor.status!)) const SizedBox(width: 4),
                    Text(
                      vendor.status!.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
    );
  }

  // Helper method to get color based on status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Colors.green;
      case 'closed':
        return Colors.red;
      case 'busy':
        return Colors.orange;
      case 'vacation':
        return Colors.blue;
      case 'new':
        return Colors.purple;
      default:
        return Colors.blueGrey;
    }
  }

  bool _shouldShowStatusIcon(String status) {
    final lowerStatus = status.toLowerCase();
    return lowerStatus == 'open' || lowerStatus == 'closed' || lowerStatus == 'busy';
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'open':
        return Icons.check_circle;
      case 'closed':
        return Icons.cancel;
      case 'busy':
        return Icons.timelapse;
      default:
        return Icons.info;
    }
  }
}
