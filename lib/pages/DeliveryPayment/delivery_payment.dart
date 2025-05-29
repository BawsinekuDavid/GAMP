// import 'package:flutter/material.dart';
// import 'package:gmarket_app/constant.dart';
// import 'package:provider/provider.dart';
// import '../../models/deliverypaymentstate.dart';
// import 'tab_content.dart';

// class DeliveryPayment extends StatelessWidget {
//   const DeliveryPayment({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider<DeliveryPaymentState>(
//       create: (_) => DeliveryPaymentState(),
//       child: Builder(
//         builder: (context) {
//           return DefaultTabController(
//             length: 2,
//             child: Scaffold(
//               backgroundColor: Colors.grey.shade200,
//               appBar: _buildAppBar(context),
//               body: const SafeArea(
//                 child: TabBarView(
//                   children: [
//                     TabContent(isPickup: true),
//                     TabContent(isPickup: false),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return AppBar(
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () => Navigator.pop(context),
//         color: colors,
//       ),
//       title: Center(
//         child: Text(
//           "Delivery and Payment",
//           style: TextStyle(
//             color: colors,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       actions: const [SizedBox(width: 48)], // Balance the title centering
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(48),
//         child: Column(
//           children: [
//             _buildTabBar(context),
//             Divider(height: 1, color: Colors.grey.shade400),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTabBar(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade300,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TabBar(
//         tabs: const [
//           Tab(text: "Self Pickup"),
//           Tab(text: "Delivery"),
//         ],
//         labelStyle: const TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 14,
//         ),
//         unselectedLabelStyle: const TextStyle(
//           fontWeight: FontWeight.normal,
//         ),
//         labelColor: colors,
//         unselectedLabelColor: Colors.grey.shade600,
//         indicator: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 4,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//         indicatorSize: TabBarIndicatorSize.tab,
//         indicatorPadding: const EdgeInsets.all(4),
//         onTap: (index) {
//           final state = Provider.of<DeliveryPaymentState>(context, listen: false);
//           state.setDeliveryFee(index == 0 ? 0.0 : 2.0);
//         },
//       ),
//     );
//   }
// }