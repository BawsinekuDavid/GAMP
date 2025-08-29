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
  final _pickupNameController = TextEditingController();
  final _pickupPhoneController = TextEditingController();
  final _pickupEmailController = TextEditingController();

  final _deliveryNameController = TextEditingController();
  final _deliveryPhoneController = TextEditingController();
  final _deliveryEmailController = TextEditingController();
  final _deliveryAddressController = TextEditingController();
  final _deliveryCityController = TextEditingController();
  final _deliveryZipController = TextEditingController();

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
      String deliveryDetails;
      if (method == "Delivery") {
        deliveryDetails =
            "${_deliveryNameController.text.trim()}, ${_deliveryPhoneController.text.trim()}, ${_deliveryEmailController.text.trim()}, ${_deliveryAddressController.text.trim()}, ${_deliveryCityController.text.trim()}, ${_deliveryZipController.text.trim()}";
      } else {
        deliveryDetails =
            "Pickup at store - ${_pickupNameController.text.trim()}, ${_pickupPhoneController.text.trim()}, ${_pickupEmailController.text.trim()}";
      }

      final order = await cartProvider.checkout(
        userId: "7ddbeb1a-9b61-493a-8c29-f90eee1c4287",
        paymentMethod: "CASH",
        deliveryFee: method == "Delivery" ? cartProvider.deliveryFee : 0,
        deliveryAddress: deliveryDetails,
      );

      final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
      await ordersProvider.fetchAndSetOrders(refresh: true);

      Fluttertoast.showToast(
        msg: "Order placed successfully!",
        backgroundColor: colors,
        textColor: Colors.white,
      );

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

  Widget _buildPickupTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyTextField(
              controller: _pickupNameController,
              hintText: "Full Name",
           
              validator: (value) => value == null || value.isEmpty ? "Enter your name" : null,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _pickupPhoneController,
              hintText: "Phone Number",
            
              validator: (value) => value == null || value.isEmpty ? "Enter your phone" : null,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _pickupEmailController,
              hintText: "Email",
              
              validator: (value) => value == null || value.isEmpty ? "Enter your email" : null,
            ),
            const SizedBox(height: 20),
            _isProcessing
                ? const CircularProgressIndicator()
                : AppBtn(
                    lbl: "Checkout with Pickup",
                    colorState: colors,
                    textColorState: Colors.white,
                    onPressed: () {
                      if (_pickupNameController.text.trim().isEmpty ||
                          _pickupPhoneController.text.trim().isEmpty ||
                          _pickupEmailController.text.trim().isEmpty) {
                        Fluttertoast.showToast(msg: "Please fill all fields");
                        return;
                      }
                      _processCheckout(method: "Pickup");
                    },
                  )
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            MyTextField(
              controller: _deliveryNameController,
              hintText: "Full Name",
            
              validator: (value) => value == null || value.isEmpty ? "Enter your name" : null,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _deliveryPhoneController,
              hintText: "Phone Number",
          
              validator: (value) => value == null || value.isEmpty ? "Enter your phone" : null,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _deliveryEmailController,
              hintText: "Email",
           
              validator: (value) => value == null || value.isEmpty ? "Enter your email" : null,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _deliveryAddressController,
              hintText: "Delivery Address",
              
              validator: (value) => value == null || value.isEmpty ? "Enter address" : null,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _deliveryCityController,
              hintText: "City",
          
              validator: (value) => value == null || value.isEmpty ? "Enter city" : null,
            ),
            const SizedBox(height: 10),
            MyTextField(
              controller: _deliveryZipController,
              hintText: "Zip Code",
        
              validator: (value) => value == null || value.isEmpty ? "Enter zip code" : null,
            ),
            const SizedBox(height: 20),
            _isProcessing
                ? const CircularProgressIndicator()
                : AppBtn(
                    lbl: "Checkout with Delivery",
                    colorState: colors,
                    textColorState: Colors.white,
                    onPressed: () {
                      if (_deliveryNameController.text.trim().isEmpty ||
                          _deliveryPhoneController.text.trim().isEmpty ||
                          _deliveryEmailController.text.trim().isEmpty ||
                          _deliveryAddressController.text.trim().isEmpty ||
                          _deliveryCityController.text.trim().isEmpty ||
                          _deliveryZipController.text.trim().isEmpty) {
                        Fluttertoast.showToast(msg: "Please fill all fields");
                        return;
                      }
                      _processCheckout(method: "Delivery");
                    },
                  )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pickupNameController.dispose();
    _pickupPhoneController.dispose();
    _pickupEmailController.dispose();
    _deliveryNameController.dispose();
    _deliveryPhoneController.dispose();
    _deliveryEmailController.dispose();
    _deliveryAddressController.dispose();
    _deliveryCityController.dispose();
    _deliveryZipController.dispose();
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