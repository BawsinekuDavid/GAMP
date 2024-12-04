// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/components/text_field.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/otp/verification.dart';

class OtpReset extends StatelessWidget {
  const OtpReset({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final numberController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image.asset(
                  "lib/images/otp.png",
                  width: 450,
                  height: 250,
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "OTP Verification",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(
                      "Enter email and phone number to send one time Password",
                      style: kTitle(context),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                MyTextField(
                    controller: emailController,
                    hintText: "Enter email",
                    obsecureText: false),
                const SizedBox(height: 20),
                MyTextField(
                    controller: numberController,
                    hintText: "Enter phone Number",
                    obsecureText: false),
                const SizedBox(height: 30),
                AppBtn(
                    lbl: "Continue",
                    colorState: colors,
                    textColorState: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/verification');
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
