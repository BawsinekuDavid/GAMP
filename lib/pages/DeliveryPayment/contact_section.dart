// import 'package:flutter/material.dart';
// import 'package:gmarket_app/components/cart_cointainers.dart';

// import 'package:provider/provider.dart';

// import '../../models/deliverypaymentstate.dart';

// class ContactSection extends StatelessWidget {
//   const ContactSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final state = Provider.of<DeliveryPaymentState>(context);

//     return CartCointainers(
//       icon: const Icon(Icons.person),
//       name: "Contact",
//       subname: state.contact,
//       tailIcon: IconButton(
//         icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
//         onPressed: () => _editContact(context),
//       ),
//     );
//   }

//   Future<void> _editContact(BuildContext context) async {
//     final state = Provider.of<DeliveryPaymentState>(context, listen: false);
//     final controller = TextEditingController(text: state.contact);

//     final result = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Edit Contact"),
//         content: TextField(
//           controller: controller,
//           decoration:
//               const InputDecoration(hintText: "Enter your phone number"),
//           keyboardType: TextInputType.phone,
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
//       state.updateContact(result);
//     }
//   }
// }
