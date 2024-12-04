import 'package:flutter/material.dart';
import 'package:gmarket_app/pages/home/home_page.dart';
import 'package:gmarket_app/pages/login_page.dart';
import 'package:gmarket_app/pages/otp/otp_reset.dart';
import 'package:gmarket_app/pages/otp/success_otp.dart';
import 'package:gmarket_app/pages/otp/verification.dart';
import 'package:gmarket_app/pages/sign_up_page.dart';
import 'package:gmarket_app/pages/splash_page.dart';
import 'package:gmarket_app/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/welcome': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/otpreset': (context) => const OtpReset(),
        '/verification': (context) => const Verification(),
        '/successotp': (context) => const SuccessOtp(),
        '/home':(context) => const HomePage(),
      },
    
    );
  }
  }