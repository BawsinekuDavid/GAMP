 
import 'package:flutter/material.dart';
import 'package:gmarket_app/pages/Orders/orders_page.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../PROVIDERS/cart_provider.dart';
import '../../PROVIDERS/ordersProvider.dart';
import '../../components/app_btn.dart';
import '../../components/text_field.dart';
import '../../constant.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _deliveryAddressController = TextEditingController();
  final _pickupNameController = TextEditingController();
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _processCheckout({required String method}) async {
  final cartProvider = Provider.of<CartProvider>(context, listen: false);

  setState(() => _isProcessing = true);

  try {
    final order = await cartProvider.checkout(
      userId: "7ddbeb1a-9b61-493a-8c29-f90eee1c4287",
      paymentMethod: "CASH",
      deliveryFee: method == "Delivery" ? cartProvider.deliveryFee : 0,
      deliveryAddress: method == "Delivery"
          ? _deliveryAddressController.text.trim()
          : "Pickup at store - ${_pickupNameController.text.trim()}",
    );

    // Notify the orders provider about the new order
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    await ordersProvider.fetchAndSetOrders(refresh: true);

    Fluttertoast.showToast(
      msg: "Order placed successfully!",
      backgroundColor: colors,
      textColor: Colors.white,
    );

    // Navigate to orders page instead of going back
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const OrdersPage(userId: '7ddbeb1a-9b61-493a-8c29-f90eee1c4287',)),
      (route) => false,
    );
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Checkout failed: ${e.toString()}",
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  } finally {
    setState(() => _isProcessing = false);
  }
}

  Widget _buildDeliveryTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          MyTextField(
            controller: _deliveryAddressController,
            hintText: "Enter delivery address",
              obsecureText: true, validator: (String? value) {
                return null;
                }, obscureText: false,
          ),
          const SizedBox(height: 20),
          _isProcessing
              ? const CircularProgressIndicator()
              : AppBtn(
                  lbl: "Checkout with Delivery",
                  colorState: colors,
                  textColorState: Colors.white,
                  onPressed: () {
                    if (_deliveryAddressController.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Enter delivery address");
                      return;
                    }
                    _processCheckout(method: "Delivery");
                  },
                )
        ],
      ),
    );
  }

  Widget _buildPickupTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          MyTextField(
            controller: _pickupNameController,
            hintText: "Enter name for pickup",
              obsecureText: true, validator: (String? value) {
                return null;
                }, obscureText: false,
          ),
          const SizedBox(height: 20),
          _isProcessing
              ? const CircularProgressIndicator()
              : AppBtn(
                  lbl: "Checkout with Pickup",
                  colorState: colors,
                  textColorState: Colors.white,
                  onPressed: () {
                    if (_pickupNameController.text.trim().isEmpty) {
                      Fluttertoast.showToast(msg: "Enter your name for pickup");
                      return;
                    }
                    _processCheckout(method: "Pickup");
                  },
                )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _deliveryAddressController.dispose();
    _pickupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: "Pickup"),
            Tab(text: "Delivery"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPickupTab(),
          _buildDeliveryTab(),
        ],
      ),
    );
  }
}
