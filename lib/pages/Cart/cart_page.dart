import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/Cart/delivery_payment.dart';
import 'package:gmarket_app/pages/Products/product_page.dart';
import 'package:provider/provider.dart';
import '../../models/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void removeFromCart(Product product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.removeFromCart(product);
  }

  

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.products;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Cart", style: TextStyle(color: Colors.white)),
        backgroundColor: colors,
        elevation: 0,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_shopping_cart,
                      size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    "Oops! Your cart is empty",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Start adding items now.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Dismissible(
                        key: ValueKey(item.name),
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => removeFromCart(item),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(item.image,
                                  width: 50, height: 50, fit: BoxFit.cover),
                            ),
                            title: Text(item.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Quantity: ${item.quantity}"),
                                Text(
                                    "Unit Price: GHC ${item.price.toStringAsFixed(2)}"),
                                Text(
                                  "Total: GHC ${(item.quantity * item.price).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removeFromCart(item),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: colors,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Total Price",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                            Text(
                              "GHC ${cartProvider.calculateTotal().toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                      // In your CartPage's checkout button
                      ElevatedButton(
                        onPressed: () {
                          final cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          cartProvider.addOrder();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DeliveryPayment()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: colors,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Checkout"),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
