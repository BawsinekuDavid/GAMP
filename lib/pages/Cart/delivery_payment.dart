import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/components/cart_cointainers.dart';

import '../../constant.dart';

class DeliveryPayment extends StatefulWidget {
  const DeliveryPayment({super.key});

  @override
  State<DeliveryPayment> createState() => _DeliveryPaymentState();
}

class _DeliveryPaymentState extends State<DeliveryPayment> {
  final promoControllerPickup = TextEditingController();
  final promoControllerDelivery = TextEditingController();
  final addressController = TextEditingController(text: "234, Nii Ayiksi St");
  final contactController = TextEditingController(text: "+233 551015625");
  String paymentMethod = "Cash";
  double subtotal = 5.00; // Example subtotal
  double deliveryFee = 0.0;
  double discount = 0.0;

  @override
  void dispose() {
    promoControllerPickup.dispose();
    promoControllerDelivery.dispose();
    addressController.dispose();
    contactController.dispose();
    super.dispose();
  }

  double calculateTotal() {
    return subtotal + deliveryFee - discount;
  }

  void applyPromoCode(String code, {bool isPickup = true}) {
    // Here you would typically validate the promo code with your backend
    // For demonstration, we'll just apply a fixed discount
    setState(() {
      if (code.isNotEmpty) {
        discount = 1.00; // GHC 1.00 discount for any non-empty code
      } else {
        discount = 0.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          iconTheme: IconThemeData(color: colors),
          title: Center(
            child: Text(
              "Delivery and Payment",
              style: TextStyle(color: colors, fontWeight: FontWeight.bold),
            ),
          ),
          bottom: TabBar(
            tabs: const [
              Tab(child: Text("Self Pickup")),
              Tab(child: Text("Delivery")),
            ],
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            labelColor: colors,
            indicatorColor: colors,
            indicator: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (index) {
              setState(() {
                deliveryFee = index == 0 ? 0.0 : 2.0;
              });
            },
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(
              context,
              promoControllerPickup,
              isPickup: true,
            ),
            _buildTabContent(
              context,
              promoControllerDelivery,
              isPickup: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(
    BuildContext context,
    TextEditingController controller, {
    required bool isPickup,
  }) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const CartCointainers(
              icon: Icon(Icons.watch_later_outlined),
              name: "Products",
              subname: "1x 1kg Read Apples GHC2.00",
              tailIcon: Icon(Icons.add_circle),
            ),
            const SizedBox(height: 20),
            CartCointainers(
              icon: const Icon(Icons.location_searching),
              name: "Address",
              subname: addressController.text,
              tailIcon: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onPressed: () => _editAddress(context),
              ),
            ),
            const SizedBox(height: 20),
            CartCointainers(
              icon: const Icon(Icons.person),
              name: "Contact",
              subname: contactController.text,
              tailIcon: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onPressed: () => _editContact(context),
              ),
            ),
            const SizedBox(height: 20),
            CartCointainers(
              icon: const Icon(Icons.payment),
              name: "Payment Option",
              subname: paymentMethod,
              tailIcon: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onPressed: () => _selectPaymentMethod(context),
              ),
            ),
            const SizedBox(height: 20),
            DottedBorder(
              color: colors,
              borderType: BorderType.RRect,
              radius: const Radius.circular(7),
              strokeWidth: 1,
              dashPattern: const [6, 3],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Add Promo Code",
                        hintStyle: TextStyle(fontSize: 20, color: colors),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        applyPromoCode(controller.text, isPickup: isPickup),
                    child: Text(
                      "APPLY",
                      style: TextStyle(color: colors),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sub Total"),
                        Text("GHC ${subtotal.toStringAsFixed(2)}"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Delivery: "),
                        Text("GHC ${deliveryFee.toStringAsFixed(2)}"),
                      ],
                    ),
                    if (discount > 0) ...[
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Discount: "),
                          Text(
                            "-GHC ${discount.toStringAsFixed(2)}",
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "GHC ${calculateTotal().toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 16,
                            color: colors,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppBtn(
                      lbl: "CONFIRM",
                      colorState: colors,
                      textColorState: Colors.white,
                      onPressed: () {
                        Fluttertoast.showToast(
                          msg: "Order Successful",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editAddress(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Address"),
        content: TextField(
          controller: addressController,
          decoration: const InputDecoration(hintText: "Enter your address"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, addressController.text);
            },
            child: const Text("SAVE"),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        addressController.text = result;
      });
    }
  }

  Future<void> _editContact(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Contact"),
        content: TextField(
          controller: contactController,
          decoration:
              const InputDecoration(hintText: "Enter your phone number"),
          keyboardType: TextInputType.phone,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("CANCEL"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, contactController.text);
            },
            child: const Text("SAVE"),
          ),
        ],
      ),
    );

    if (result != null) {
      setState(() {
        contactController.text = result;
      });
    }
  }

  Future<void> _selectPaymentMethod(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Payment Method"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Cash"),
              leading: Radio(
                value: "Cash",
                groupValue: paymentMethod,
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              ),
            ),
            ListTile(
              title: const Text("Mobile Money"),
              leading: Radio(
                value: "Mobile Money",
                groupValue: paymentMethod,
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              ),
            ),
            ListTile(
              title: const Text("Card"),
              leading: Radio(
                value: "Card",
                groupValue: paymentMethod,
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              ),
            ),
          ],
        ),
      ),
    );

    if (result != null) {
      setState(() {
        paymentMethod = result;
      });
    }
  }
}
