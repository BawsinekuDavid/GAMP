import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/components/bottom_nav_bar.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/Purchasing/purchase_page.dart';
 
class CartPage extends StatelessWidget {
  final Function()? onPressed;
  // ignore: prefer_typing_uninitialized_variables
  final  icon;
  const CartPage({super.key, this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const BottomNavBar(category: 'fruits',)));
                  },
                  icon: const Icon(Icons.cancel_outlined, ), iconSize: 50,color: colors,)
            ]),
            const SizedBox(height: 100),
            Image.asset("lib/images/emptycart.png"),
            const SizedBox(height: 35),
            const Text(
              "You do not have anything in your cart",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            AppBtn(
                lbl: "Add An Item",
                colorState: colors,
                textColorState: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PurchasePage()));
                })
          ],
        ),
      ),
    );
  }
}
