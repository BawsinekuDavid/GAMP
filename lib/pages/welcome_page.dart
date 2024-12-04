import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';

import '../constant.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "EXCELLENT VENDORS",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              const Text(
                "Carefully chosen for you!",
                style: TextStyle(fontSize: 20),
              ),
              //

              const SizedBox(height: 50),

              DottedBorder(
                borderType: BorderType.Circle,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(50),
                color: colors,
                child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    child: Icon(
                      Icons.shopping_cart,
                      color: colors,
                      size: 70,
                    )),
              ),
              const SizedBox(height: 100),

              AppBtn(
                  lbl: "SIGN IN",
                  colorState: colors,
                  textColorState: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  }),
              const SizedBox(height: 50),

              AppBtn(
                  lbl: "SIGN UP",
                  colorState: Colors.white,
                  textColorState: colors,
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
