import 'package:flutter/material.dart';
import 'package:gmarket_app/pages/welcome_page.dart';

import '../components/app_btn.dart';
import '../components/text_field.dart';
import '../constant.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
     final fullnameController = TextEditingController();
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
                Icon(Icons.shopping_cart,
                color: colors,
                size: 40,),
                const SizedBox(width: 20),
                const Text(
                  "Create Account",
                  style: TextStyle(fontSize: 25),
                  
                ),
              ],
            ),

            
            const SizedBox(height: 30),
            
            Center(
              
              
              child: MyTextField(controller: fullnameController, hintText: 'fullname', obsecureText: false),
              ),

              const SizedBox(height: 20),


              MyTextField(controller: emailController, hintText: "email", obsecureText: false),
            
              
              const SizedBox(height: 20),

              MyTextField(controller: passwordController, hintText: "password", obsecureText: true),

              const SizedBox(height: 50),
        
              
              //sign in button
              AppBtn(lbl: "Sign Up", onPressed: ( ) {Navigator.push(context, MaterialPageRoute(builder: (context)=> const WelcomePage()));}, colorState: colors, textColorState: Colors.white,),

             const SizedBox(height: 50),

               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                 const Text(
                    "By signing up you agree to our"
                  ),
                 const SizedBox(width: 2),

              Text(
                "Terms and Conditions",
                style: TextStyle(
                  color: colors,
                  decoration: TextDecoration.underline
                 ),
               )
                ],
              ),
              
              
          ],
        
          
          
        ),
      ),

    

        
    );
  }
}