import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/components/cart_cointainers.dart';
import 'package:gmarket_app/pages/Orders/order_sucessful.dart';

import '../../constant.dart';

class DeliveryPayment extends StatefulWidget {
  const DeliveryPayment({super.key});

  @override
  State<DeliveryPayment> createState() => _DeliveryPaymentState();
}

class _DeliveryPaymentState extends State<DeliveryPayment> {
  final promoControllerPickup = TextEditingController();
  final promoControllerDelivery = TextEditingController();

  // Placeholder for calculating total
  String calculateTotal({double subtotal = 5.00, double delivery = 0.0}) {
    double total = subtotal + delivery;
    return total.toStringAsFixed(2);
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
              Tab(
                child: Text("Self Pickup"),
              ),
              Tab(
                child: Text("Delivery"),
              ),
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
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(
              context,
              promoControllerPickup,
              deliveryFee: 0.0,
              totalLabel: calculateTotal(subtotal: 5.00),
            ),
            _buildTabContent(
              context,
              promoControllerDelivery,
              deliveryFee: 2.00,
              totalLabel: calculateTotal(subtotal: 5.00, delivery: 2.00),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, TextEditingController controller,
      {required double deliveryFee, required String totalLabel}) {
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
            const CartCointainers(
              icon: Icon(Icons.location_searching),
              name: "Address",
              subname: "234, Nii Ayiksi St",
              tailIcon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const CartCointainers(
              icon: Icon(Icons.person),
              name: "Contact",
              subname: "+233 551015625",
              tailIcon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const CartCointainers(
              icon: Icon(Icons.watch_later_outlined),
              name: "Payment Option",
              subname: "Cash",
              tailIcon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            DottedBorder(
              color: colors,
              borderType: BorderType.RRect,
              radius: const Radius.circular(7),
              strokeWidth: 1,
              dashPattern: const [6, 3],
              child: TextField(
                textAlign: TextAlign.center,
                controller: controller,
                decoration: InputDecoration(
                  focusColor: colors,
                  hintText: "Add Promo Code",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: colors,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sub Total"),
                          Text("Ghc 5.00"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Delivery: "),
                          Text("Ghc ${deliveryFee.toStringAsFixed(2)}"),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total: "),
                          Text(
                            "Ghc $totalLabel",
                            style: TextStyle(fontSize: 16, color: colors),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      AppBtn(
                        lbl: "CONFIRM",
                        colorState: colors,
                        textColorState: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderSucessful(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
