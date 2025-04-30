import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/sign_up_page.dart';

import '../Auth/auth_service.dart';
import '../components/app_btn.dart';
import '../components/text_field.dart';
import '../main.dart';
 

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  bool isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  void _login() async {
    setState(() => _isLoading = true);

    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      setState(() => _isLoading = false);
      return;
    }

    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email address")),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      var user = await _authService.login(email, password, context);

      if (user != null) {
        print("User authenticated: $user");
        Navigator.pushReplacementNamed(context, RouteNames.home);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login failed. Check credentials.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: ${e.toString()}")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
   

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
                controller: _emailController,
                hintText: "Email",
                obsecureText: false, ),

            const SizedBox(height: 20),

             TextField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle:const TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.shade100),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green.shade400)),
            suffixIcon: IconButton(
              onPressed: ( ){
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
            }, icon: Icon(
              _isPasswordVisible
            ? Icons.visibility
            : Icons.visibility_off,
            )
            )
                ),
              

              ),
             

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
              lbl: _isLoading ? "LOGGING IN..." : "LOGIN",
              onPressed:  _login,
              colorState: colors,
              textColorState: Colors.white,
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Dont have an Account?"),
                const SizedBox(width: 2),
                InkWell(
                  onTap: () {
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignUpPage()));
                  },
                  child: Text(
                    "Sign up here",
                    style: TextStyle(
                        color: colors, decoration: TextDecoration.underline),
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
