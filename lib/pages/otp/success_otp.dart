import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/constant.dart';

class SuccessOtp extends StatelessWidget {
  const SuccessOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text(
                "SUCCESS!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 50),

              Text(
                "Congratulations! You have been successfully authenticated",
                style: kTitle(context),
              ),
              const SizedBox(height: 50),
              
              AppBtn(
                  lbl: "Continue",
                  colorState: colors,
                  textColorState: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
