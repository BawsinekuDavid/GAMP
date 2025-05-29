// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:gmarket_app/PROVIDERS/orders_provider.dart';
// import 'package:gmarket_app/components/cart_containers.dart';
// import 'package:gmarket_app/components/order_containers.dart';
// import '../../PROVIDERS/ordersProvider.dart';
// import '../../components/cart_cointainers.dart';
// import 'address_section.dart';
// import 'contact_section.dart';
// import 'payment_section.dart';
// import 'promo_code.dart';
// import 'summary_section.dart';
// import '../../PROVIDERS/cart_provider.dart';

// class TabContent extends StatefulWidget {
//   final bool isPickup;
  
//   const TabContent({
//     super.key,
//     required this.isPickup,
//   });

//   @override
//   State<TabContent> createState() => _TabContentState();
// }

// class _TabContentState extends State<TabContent> {
//   @override
//   Widget build(BuildContext context) {
//     final cartProvider = Provider.of<CartProvider>(context);
//     final ordersProvider = Provider.of<OrdersProvider>(context);

//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Display current order summary if available
//             if (ordersProvider.currentOrder != null)
//               Column(
//                 children: [
//                   OrderContainer(
//                     order: ordersProvider.currentOrder!,
//                     onTap: () {
//                       // Handle order tap if needed
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
            
//             // Display cart items
//             ...cartProvider.cartItems.map((item) => Padding(
//               padding: const EdgeInsets.only(bottom: 12),
//               child: CartContainers(
//                 name: item.product,
//                 quantity: item.quantity,
//                 unitPrice: item.unitPrice,
//                 icon: item.imageUrl.isNotEmpty
//                     ? ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           item.imageUrl,
//                           width: 40,
//                           height: 40,
//                           fit: BoxFit.cover,
//                           errorBuilder: (_, __, ___) => const Icon(Icons.shopping_bag),
//                         ),
//                       )
//                     : const Icon(Icons.shopping_bag),
//                 onIncrement: () => cartProvider.incrementQuantity(item.id),
//                 onDecrement: () => cartProvider.decrementQuantity(item.id),
//                 onRemove: () => cartProvider.removeItem(item.id),
//               ),
//             )).toList(),
            
//             const SizedBox(height: 20),
//             // Only show address section if not pickup
//             if (!widget.isPickup) const AddressSection(),
//             if (!widget.isPickup) const SizedBox(height: 20),
            
//             const ContactSection(),
//             const SizedBox(height: 20),
//             const PaymentSection(),
//             const SizedBox(height: 20),
//             const PromoCodeSection(),
//             const SizedBox(height: 15),
//             const SummarySection(),
//             const SizedBox(height: 20), // Extra space at bottom
//           ],
//         ),
//       ),
//     );
//   }
// }