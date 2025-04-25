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

import 'db/db_helper.dart';
import 'pages/Products/product_page.dart';



class RouteNames {
  static const String splash = '/';
  static const String welcome = "/welcome";
  static const String login = "/login";
  static const String home = "/home";
 
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ProductAdapter());
  }
 //Hive.openBox<Product>('cartBox');
  
 // Initialize database
  final dbHelper = DbHelper();
  await dbHelper.database; // Ensure database is initialized
  
  // Check if database is empty before populating
  final existingProducts = await dbHelper.getAllProducts();
  if (existingProducts.isEmpty) {
    await populateDatabase();
  }

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
      initialRoute: RouteNames.splash,
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
