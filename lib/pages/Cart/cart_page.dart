import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/DeliveryPayment/payment_page.dart';
 
import 'package:provider/provider.dart';
import '../../PROVIDERS/cart_provider.dart';
import '../../models/products_module.dart';
 
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    // Load cart items when the page initializes
    Provider.of<CartProvider>(context, listen: false).loadCartItems();
  }

  void removeFromCart(Product product) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.removeFromCart(product.id);
    Fluttertoast.showToast(msg: 
    "Removed Fropm cart",
    backgroundColor: colors,
    textColor: Colors.white);
  }
  

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Center(
            child: Text("Cart", style: TextStyle(color: Colors.white))),
        backgroundColor: colors,
        elevation: 0,
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep, color: Colors.white),
              onPressed: () {
                cartProvider.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cart cleared'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
        ],
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
                        key: Key(
                            item.id), // Use unique id instead of product name
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerRight,
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Confirm"),
                              content:
                                  Text("Remove ${item.product} from cart?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("Remove"),
                                ),
                              ],
                            ),
                          );
                        },
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
                              child: Image.network(
                                // Changed to network for API images
                                item.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image),
                              ),
                            ),
                            title: Text(item.product,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                     
                                    Text(item.quantity.toString()),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline,
                                          size: 20),
                                      onPressed: () {
                                        cartProvider.updateQuantity(
                                          item.id,
                                          item.quantity + 1,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                    "Unit Price: GHC ${item.unitPrice.toStringAsFixed(2)}"),
                                Text(
                                  "Total: GHC ${(item.quantity * item.unitPrice).toStringAsFixed(2)}",
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: colors,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal",
                                style: TextStyle(color: Colors.white)),
                            // Text(
                            //   "GHC ${cartProvider._calculateSubtotal().toStringAsFixed(2)}",
                            //   style: const TextStyle(color: Colors.white),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Delivery Fee",
                                style: TextStyle(color: Colors.white)),
                            Text(
                              "GHC ${cartProvider.deliveryFee.toStringAsFixed(2)}",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.white54, height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Price",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            // Text(
                            //   "GHC ${cartProvider.calculateSuTotal().toStringAsFixed(2)}",
                            //   style: const TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.bold),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: colors,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text("Proceed to Checkout"),
                          ),
                        )
                      ],
                    )),
              ],
            ),
    );
  }
}
