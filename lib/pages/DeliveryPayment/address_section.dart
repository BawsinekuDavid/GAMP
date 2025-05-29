// import 'package:flutter/material.dart';
// import 'package:gmarket_app/components/cart_cointainers.dart';

// import 'package:provider/provider.dart';

// import '../../models/deliverypaymentstate.dart';

// class AddressSection extends StatelessWidget {
//   const AddressSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final state = Provider.of<DeliveryPaymentState>(context);

//     return CartCointainers(
//       icon: const Icon(Icons.location_searching),
//       name: "Address",
//       subname: state.address,
//       tailIcon: IconButton(
//         icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
//         onPressed: () => _editAddress(context),
//       ),
//     );
//   }

//   Future<void> _editAddress(BuildContext context) async {
//     final state = Provider.of<DeliveryPaymentState>(context, listen: false);
//     final controller = TextEditingController(text: state.address);

//     final result = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Edit Address"),
//         content: TextField(
//           controller: controller,
//           decoration: const InputDecoration(hintText: "Enter your address"),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("CANCEL"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context, controller.text);
//             },
//             child: const Text("SAVE"),
//           ),
//         ],
//       ),
//     );

//     if (result != null) {
//       state.updateAddress(result);
//     }
//   }
// }
