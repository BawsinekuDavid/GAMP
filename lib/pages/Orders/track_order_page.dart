import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';

class TrackOrderPage extends StatelessWidget {
  final String orderId;
  final String vendorName;
  final String vendorImage;
  final String currentStatus;
  final String deliveryAddress;
  final String contactNumber;
  final String paymentMethod;
  final String totalAmount;
  final DateTime orderDate;
  
  const TrackOrderPage({
    super.key,
    required this.orderId,
    required this.vendorName,
    required this.vendorImage,
    required this.currentStatus,
    required this.deliveryAddress,
    required this.contactNumber,
    required this.paymentMethod,
    required this.totalAmount,
    required this.orderDate,
  });

  @override
  Widget build(BuildContext context) {
    // Define all possible order statuses in sequence
    final List<String> allStatuses = [
      "Order Placed",
      "Vendor has confirmed order",
      "Preparing Order",
      "Looking for Courier",
      "Courier has been found",
      "Courier is on the way to you",
      "Order Delivered"
    ];

    // Get current status index
    final currentIndex = allStatuses.indexOf(currentStatus);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          toolbarHeight: 200,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 10,
          backgroundColor: colors,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(vendorImage), // Changed to NetworkImage
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vendorName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Order #$orderId",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Placed on ${_formatDate(orderDate)}",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Status",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Timeline view of order status
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allStatuses.length,
              itemBuilder: (context, index) {
                final isCompleted = index < currentIndex;
                final isCurrent = index == currentIndex;
                final isLast = index == allStatuses.length - 1;
                
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Timeline indicator
                        Column(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted 
                                  ? Colors.green
                                  : isCurrent
                                    ? colors
                                    : Colors.grey[300],
                              ),
                              child: isCompleted
                                ? const Icon(Icons.check, size: 16, color: Colors.white)
                                : null,
                            ),
                            if (!isLast)
                              Container(
                                width: 2,
                                height: 40,
                                color: isCompleted ? Colors.green : Colors.grey[300],
                              ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        
                        // Status text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                allStatuses[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: isCurrent 
                                    ? FontWeight.bold 
                                    : FontWeight.normal,
                                  color: isCurrent 
                                    ? colors 
                                    : isCompleted
                                      ? Colors.green
                                      : Colors.grey),
                              ),
                              if (isCurrent)
                                const SizedBox(height: 5),
                              if (isCurrent)
                                Text(
                                  _getStatusTimeEstimate(index),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey),
                                ),
                              if (isCurrent && index == allStatuses.length - 1)
                                const SizedBox(height: 5),
                              if (isCurrent && index == allStatuses.length - 1)
                                Text(
                                  "Delivered on ${_formatDate(orderDate.add(const Duration(hours: 1)))}", // Example delivery time
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 30),
            
            // Delivery details card
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    
                    // Order summary
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    _buildOrderItem("1x Red Apples (1kg)", "GHC 5.00"),
                    _buildOrderItem("Delivery Fee", "GHC 2.00"),
                    const Divider(),
                    _buildOrderItem("Total", totalAmount, isTotal: true),
                    const SizedBox(height: 20),
                    
                    // Delivery details
                    const Text(
                      "Delivery Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    _buildDetailRow(Icons.location_on, "Delivery Address", deliveryAddress),
                    const Divider(),
                    _buildDetailRow(Icons.phone, "Contact Number", contactNumber),
                    const Divider(),
                    _buildDetailRow(Icons.payment, "Payment Method", paymentMethod),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Contact buttons
            if (currentIndex < allStatuses.length - 1)
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.message),
                      label: const Text("Message Vendor"),
                      onPressed: () {
                        // Implement messaging functionality
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        side: BorderSide(color: colors),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.call),
                      label: const Text("Call Vendor"),
                      onPressed: () {
                        // Implement calling functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colors, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String name, String price, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? colors : null),
          ),
        ],
      ),
    );
  }

  String _getStatusTimeEstimate(int index) {
    switch (index) {
      case 0: return "Order placed at ${_formatTime(orderDate)}";
      case 1: return "Confirmed at ${_formatTime(orderDate.add(const Duration(minutes: 10)))}";
      case 2: return "Estimated preparation time: 20-30 minutes";
      case 3: return "Searching for available couriers";
      case 4: return "Courier assigned at ${_formatTime(orderDate.add(const Duration(minutes: 45)))}";
      case 5: return "Estimated delivery time: ${_formatTime(orderDate.add(const Duration(minutes: 75)))}";
      case 6: return "Delivered at ${_formatTime(orderDate.add(const Duration(hours: 1, minutes: 30)))}";
      default: return "";
    }
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String _formatTime(DateTime date) {
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}