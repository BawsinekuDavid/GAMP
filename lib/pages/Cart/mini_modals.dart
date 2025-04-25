
// import 'package:flutter/material.dart';


//   final promoControllerPickup = TextEditingController();
//   final promoControllerDelivery = TextEditingController();
//   final addressController = TextEditingController(text: "234, Nii Ayiksi St");
//   final contactController = TextEditingController(text: "+233 551015625");
//   String paymentMethod = "Cash";
//   double subtotal = 5.00; // Example subtotal
//   double deliveryFee = 0.0;
//   double discount = 0.0;

// Future<void> _editAddress(BuildContext context) async {
//     final result = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Edit Address"),
//         content: TextField(
//           controller: addressController,
//           decoration: InputDecoration(hintText: "Enter your address"),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("CANCEL"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context, addressController.text);
//             },
//             child: Text("SAVE"),
//           ),
//         ],
//       ),
//     );

//     if (result != null) {
//       setState(() {
//         addressController.text = result;
//       });
//     }
//   }
// void applyPromoCode(String code, {bool isPickup = true}) {
//     // Here you would typically validate the promo code with your backend
//     // For demonstration, we'll just apply a fixed discount
//     setState(() {
//       if (code.isNotEmpty) {
//         discount = 1.00; // GHC 1.00 discount for any non-empty code
//       } else {
//         discount = 0.0;
//       }
//     });
//   }
  

//   Future<void> _editContact(BuildContext context) async {
//     final result = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Edit Contact"),
//         content: TextField(
//           controller: contactController,
//           decoration: InputDecoration(hintText: "Enter your phone number"),
//           keyboardType: TextInputType.phone,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text("CANCEL"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context, contactController.text);
//             },
//             child: Text("SAVE"),
//           ),
//         ],
//       ),
//     );

//     if (result != null) {
//       setState(() {
//         contactController.text = result;
//       });
//     }
//   }

//   Future<void> _selectPaymentMethod(BuildContext context) async {
//     final result = await showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Select Payment Method"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               title: Text("Cash"),
//               leading: Radio(
//                 value: "Cash",
//                 groupValue: paymentMethod,
//                 onChanged: (value) {
//                   Navigator.pop(context, value);
//                 },
//               ),
//             ),
//             ListTile(
//               title: Text("Mobile Money"),
//               leading: Radio(
//                 value: "Mobile Money",
//                 groupValue: paymentMethod,
//                 onChanged: (value) {
//                   Navigator.pop(context, value);
//                 },
//               ),
//             ),
//             ListTile(
//               title: Text("Card"),
//               leading: Radio(
//                 value: "Card",
//                 groupValue: paymentMethod,
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
//       setState(() {
//         paymentMethod = result;
//       });
//     }
//   }