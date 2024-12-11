import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/constant.dart';

class EmptyCartPage extends StatelessWidget {
  const EmptyCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
        
          children: [
              Icon(Icons.cancel_outlined),

              Image.asset("lib/images/emptycart.png"),
        
              Text("You do not have anything in your cart"),
        
              AppBtn(lbl: "Add and Item", colorState: colors, textColorState: Colors.white, onPressed:() {})
          ],
        ),
      ),
    );
  }
}