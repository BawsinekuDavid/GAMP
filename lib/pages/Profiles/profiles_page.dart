import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/Profiles/edit_profile_page.dart';

import '../../components/text_field.dart';

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({super.key});

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
            "Profile",
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
           validator: (String? value) {
                return null;
                },  
            ),
            const SizedBox(height: 50),
            MyTextField(
              controller: emailController,
              hintText: "email",
          
               validator: (String? value) {
                 return null;
                 }, 
            ),
            const SizedBox(height: 50),
            MyTextField(
              controller: phoneController,
              hintText: "phone number",
             validator: (String? value) {
                return null;
                }, 
            ),
            const SizedBox(height: 50),
            MyTextField(
              controller: paymentModeController,
              hintText: "mode",
           
               validator: (String? value) {
                 return null;
                 }, 
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DynamicBtn(
                    label2: "Edit Profile",
                    shadowColor2: Colors.grey,
                    textColorState2: Colors.white,
                    colorState2: colors,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditProfilePage()));
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
