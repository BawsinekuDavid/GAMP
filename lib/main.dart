import 'package:flutter/material.dart';
import 'package:gmarket_app/components/bottom_nav_bar.dart';
import 'package:gmarket_app/models/cart_provider.dart';
import 'package:gmarket_app/pages/login_page.dart';
import 'package:gmarket_app/pages/otp/otp_reset.dart';
import 'package:gmarket_app/pages/otp/success_otp.dart';
import 'package:gmarket_app/pages/otp/verification.dart';
import 'package:gmarket_app/pages/sign_up_page.dart';
import 'package:gmarket_app/pages/splash_page.dart';
import 'package:gmarket_app/pages/welcome_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'pages/Products/product_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());

  // Open the box here before the app starts
  await Hive.openBox<Product>('cartbox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()), // CartProvider is initialized here
      ],
      child: const MyApp(),
    ),
  );
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
        '/home': (context) => const BottomNavBar(
              category: 'fruits',
            ),
      },
    );
  }
}
