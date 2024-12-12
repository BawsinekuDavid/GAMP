import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/otp/otp_reset.dart';

import '../components/app_btn.dart';
import '../components/text_field.dart';
 

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
     final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: colors,
                  size: 40,
                ),
                const SizedBox(width: 20),
                const Text(
                  "Sign In",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),

            const SizedBox(height: 50),

            MyTextField(
                controller: emailController,
                hintText: "email",
                obsecureText: false, ),

            const SizedBox(height: 50),

            MyTextField(
                controller: passwordController,
                hintText: "password",
                obsecureText: true),

            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Forget Password",
                style: TextStyle(color: colors,
                fontSize: 16),),
              ],
            ),

            const SizedBox(height: 50),

            //sign in button
            AppBtn(
              lbl: "Login",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OtpReset()));
              },
              colorState: colors,
              textColorState: Colors.white,
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Dont have an Account?"),
                const SizedBox(width: 2),
                Text(
                  "Sign up here",
                  style: TextStyle(
                      color: colors, decoration: TextDecoration.underline),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
