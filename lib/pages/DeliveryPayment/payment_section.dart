// import 'package:flutter/material.dart';
// import 'package:gmarket_app/components/cart_cointainers.dart';
 
// import 'package:provider/provider.dart';

// import '../../models/deliverypaymentstate.dart';

// class PaymentSection extends StatelessWidget {
//   const PaymentSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final state = Provider.of<DeliveryPaymentState>(context);
    
//     return CartCointainers(
//       icon: const Icon(Icons.payment),
//       name: "Payment Option",
//       subname: state.paymentMethod,
//       tailIcon: IconButton(
//         icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
//         onPressed: () => _selectPaymentMethod(context),
//       ),
//     );
//   }

//   Future<void> _selectPaymentMethod(BuildContext context) async {
//     final state = Provider.of<DeliveryPaymentState>(context, listen: false);
    
//     final result = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Select Payment Method"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               title: const Text("Cash"),
//               leading: Radio(
//                 value: "Cash",
//                 groupValue: state.paymentMethod,
//                 onChanged: (value) {
//                   Navigator.pop(context, value);
//                 },
//               ),
//             ),
//             ListTile(
//               title: const Text("Mobile Money"),
//               leading: Radio(
//                 value: "Mobile Money",
//                 groupValue: state.paymentMethod,
//                 onChanged: (value) {
//                   Navigator.pop(context, value);
//                 },
//               ),
//             ),
//             ListTile(
//               title: const Text("Card"),
//               leading: Radio(
//                 value: "Card",
//                 groupValue: state.paymentMethod,
//                 onChanged: (value) {
//                   Navigator.pop(context, value);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

//     if (result != null) {
//       state.updatePaymentMethod(result);
//     }
//   }
// }