import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/components/text_field.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/Profiles/profiles_page.dart';
import 'package:gmarket_app/pages/sign_up_page.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final paymentModeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Edit Profile",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ClipOval(
                child: Image.asset(
                  "lib/images/profile.jpg",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 50),
            MyTextField(
              controller: nameController,
              hintText: "name",
              obsecureText: false,
            ),
            const SizedBox(height: 50),
            MyTextField(
              controller: emailController,
              hintText: "email",
              obsecureText: false,
            ),
            const SizedBox(height: 50),
            MyTextField(
              controller: phoneController,
              hintText: "phone number",
              obsecureText: false,
            ),
            const SizedBox(height: 50),
            MyTextField(
              controller: paymentModeController,
              hintText: "mode",
              obsecureText: false,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DynamicBtn(
                    label2: "SAVE CHANGES",
                    shadowColor2: Colors.grey,
                    textColorState2: Colors.white,
                    colorState2: colors,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilesPage()));
                    }),
                DynamicBtn(
                    label2: "LOGOUT",
                    shadowColor2: Colors.grey,
                    textColorState2: Colors.white,
                    colorState2: colors,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
