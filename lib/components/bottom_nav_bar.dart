import 'package:flutter/material.dart';
 
import '../pages/Cart/cart_page.dart';
import '../pages/Orders/orders_page.dart';
import '../pages/Profiles/profiles_page.dart';
import '../pages/home/home_page.dart';
import '../pages/promotions/promotions_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  // Define screens as a list of widgets
  final List<Widget> screens = [
    const HomePage(),
    const PromotionsPage(),
    const CartPage(),
    const OrdersPage(),
    const ProfilesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex], // Show the selected screen
      
      bottomNavigationBar:
      
       BottomNavigationBar(
      
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index), // Update index
        selectedItemColor: Colors.green, // Active tab color
        unselectedItemColor: Colors.grey, // Inactive tab color
        type: BottomNavigationBarType.fixed,
         // Fixed style
        items: const [
          
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on),
            label: "Promotions",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_sharp),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
