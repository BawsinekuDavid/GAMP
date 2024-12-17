import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gmarket_app/models/cart_provider.dart';
import 'package:gmarket_app/pages/Cart/cart_page.dart';
import '../pages/Orders/orders_page.dart';
import '../pages/Profiles/profiles_page.dart';
import '../pages/home/home_page.dart';

class BottomNavBar extends StatefulWidget {
  final String category;
  const BottomNavBar({super.key, required this.category});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  // Define screens as a list of widgets
  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    // Initialize screens
    screens = [
      const HomePage(),
      const CartPage(),
      OrdersPage(),
      const ProfilesPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: screens[currentIndex], // Show the selected screen

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index), // Update index
        selectedItemColor: Colors.green, // Active tab color
        unselectedItemColor: Colors.grey, // Inactive tab color
        type: BottomNavigationBarType.fixed, // Fixed style
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_bag),
                if (cartProvider.product.isNotEmpty)
                  Positioned(
                    right: -6,
                    top: -6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red, // Badge background color
                        borderRadius: BorderRadius.circular(12),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        cartProvider.product.length.toString(), // Cart count
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: "Cart",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_sharp),
            label: "Orders",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
