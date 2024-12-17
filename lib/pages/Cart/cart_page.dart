// import 'package:flutter/material.dart';
// import 'package:gmarket_app/components/app_btn.dart';
// import 'package:gmarket_app/components/bottom_nav_bar.dart';
// import 'package:gmarket_app/constant.dart';
// import 'package:gmarket_app/pages/Purchasing/purchase_page.dart';
 
// class CartPage extends StatelessWidget {
//   final Function()? onPressed;
//   // ignore: prefer_typing_uninitialized_variables
//   final  icon;
//   const CartPage({super.key, this.onPressed, this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               IconButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => const BottomNavBar(category: 'fruits',)));
//                   },
//                   icon: const Icon(Icons.cancel_outlined, ), iconSize: 50,color: colors,)
//             ]
// ),
//             const SizedBox(height: 100),
//             Image.asset("lib/images/emptycart.png"),
//             const SizedBox(height: 35),
//             const Text(
//               "You do not have anything in your cart",
//               style: TextStyle(fontSize: 16, color: Colors.grey),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 35),
//             AppBtn(
//                 lbl: "Add An Item",
//                 colorState: colors,
//                 textColorState: Colors.white,
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const PurchasePage()));
//                 })
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gmarket_app/pages/Products/product_page.dart';
import 'package:provider/provider.dart';
import '../../models/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Function to remove item from the cart
  void removeFromCart(Product product, BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    cartProvider.removeFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Cart Page")),
      body: cartProvider.product.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Your Cart is Empty",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: cartProvider.product.length,
              itemBuilder: (context, index) {
                final item = cartProvider.product[index];
                return Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 20),
                
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300
                  ),
                  child: ListTile(
                    leading: Image.asset(item.image, width: 50, height: 50),
                    title: Text(item.name),
                    subtitle: Text("Quantity: ${item.quantity}"),
                    trailing: IconButton(
                      onPressed: () => removeFromCart(item, context),
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
