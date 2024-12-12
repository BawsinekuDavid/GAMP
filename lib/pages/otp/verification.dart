import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/components/text_field.dart';
import 'package:gmarket_app/constant.dart';

class Verification extends StatelessWidget {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    final codeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        leading: IconButton(onPressed: () {Navigator.pushNamed(context, '/successotp');}, icon: const Icon(Icons.arrow_back),
        color: colors,),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const Text(
                "Verification Code",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Text("We have sent the verification code to your email address",
                  style: kTitle(context)),
              const SizedBox(height: 20),
              MyTextField(
                  controller: codeController,
                  hintText: "Enter code",
                  obsecureText: true,),
              const SizedBox(height: 20),
              AppBtn(
                  lbl: "Confirm",
                  colorState: colors,
                  textColorState: Colors.white,
                  onPressed: () {Navigator.pushNamed(context, '/successotp');})
            ],
          ),
        ),
      ),
    );
  }
}
