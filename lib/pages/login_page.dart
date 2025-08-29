import 'package:flutter/material.dart';
import 'package:gmarket_app/Endpoints/userapi.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/models/user_model.dart';
import 'package:gmarket_app/pages/sign_up_page.dart';
import '../components/app_btn.dart';
import '../components/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String? _errorMessage;
  final _formKey = GlobalKey<FormState>();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
try {
  final response = await Userapi().login(
    UserModel(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    ),
  );
  
  // Now you can access:
  print(response.token); // The JWT token
  print(response.email); // User's email
  print(response.fullName); // User's full name
  
  // Save this data as needed
  // await _saveAuthData(
  //   token: response.token,
  //   email: response.email,
  //   name: response.fullName,
  // );
  
  if (!mounted) return;
  Navigator.pushReplacementNamed(context, "/home");
} catch (e) {
 setState(() {
        _errorMessage = e.toString().replaceAll("Exception: ", '');
        _isLoading = false;
      });
}
     
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
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

                // Email Field
                MyTextField(
                  controller: _emailController,
                  hintText: "Email",
                  validator: _validateEmail,  
                ),
                const SizedBox(height: 20),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  validator: _validatePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green.shade100),
                      borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.green.shade400)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      }, 
                      icon: Icon(
                        _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),

                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],

                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Add forgot password navigation
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: colors, fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Login Button
                AppBtn(
                  lbl: _isLoading ? "LOGGING IN..." : "LOGIN",
                  onPressed:   _submit,
                  colorState: colors,
                  textColorState: Colors.white,
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an Account?"),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                        );
                      },
                      child: Text(
                        "Sign up here",
                        style: TextStyle(
                          color: colors,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}