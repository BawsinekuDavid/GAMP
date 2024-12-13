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
  @override
  Widget build(BuildContext context) {
    final promoController = TextEditingController();
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
                child: Text("self pickup"),
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
                borderRadius: BorderRadius.circular(10)),
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
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
                      tailIcon:
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    const CartCointainers(
                      icon: Icon(Icons.watch_later_outlined),
                      name: "Payment Option",
                      subname: "Cash",
                      tailIcon:
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                   DottedBorder(
                      color: colors, // Set your border color
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(7),
                      strokeWidth: 1,
                      dashPattern: const [
                        6,
                        3
                      ], // Dotted pattern: dash length and gap
                      child: TextField(
                        textAlign: TextAlign.center,
                      controller: promoController,
                      decoration: InputDecoration(
                        focusColor: colors,
                        hintText: "Add Promo Code",
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: colors,
                        ),
                      border: InputBorder.none
                      ),
                    ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      child: Container(
                        width: double
                            .infinity, // Use double.infinity for responsive width
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sub Total"),
                                  Text("Ghc 5.00"),
                                ],
                              ),
                              const SizedBox(height: 20),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Total: "),
                                  Text(
                                    "Ghc 5.00",
                                    style:
                                        TextStyle(fontSize: 16, color: colors),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: 20), // Add spacing before the button
                              AppBtn(
                                lbl: "CONFRIM",
                                colorState: colors,
                                textColorState: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OrderSucessful()));
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
            ),

            //DELIVERY TAB

            Padding(
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
                      tailIcon:
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    const CartCointainers(
                      icon: Icon(Icons.watch_later_outlined),
                      name: "Delivery Time",
                      subname: "As soon as possible",
                      tailIcon:
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    const CartCointainers(
                      icon: Icon(Icons.watch_later_outlined),
                      name: "Payment Option",
                      subname: "Momo",
                      tailIcon:
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    DottedBorder(
                      color: colors, // Set your border color
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(7),
                      strokeWidth: 1,
                      dashPattern: const [
                        6,
                        3
                      ], // Dotted pattern: dash length and gap
                      child: TextField(
                        textAlign: TextAlign.center,
                      controller: promoController,
                      decoration: InputDecoration(
                        focusColor: colors,
                        hintText: "Add Promo Code",
                        hintStyle: TextStyle(
                          fontSize: 20,
                          color: colors,
                        ),
                      border: InputBorder.none
                      ),
                    ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      child: Container(
                        width: double
                            .infinity, // Use double.infinity for responsive width
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Sub Total"),
                                  Text("Ghc 5.00"),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Delivery: "),
                                  Text("Ghc 2.00"),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Total: "),
                                  Text(
                                    "Ghc 7.00",
                                    style:
                                        TextStyle(fontSize: 16, color: colors),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                  height: 20), // Add spacing before the button
                              AppBtn(
                                lbl: "CONFRIM",
                                colorState: colors,
                                textColorState: Colors.white,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OrderSucessful()));
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
            ),
          ],
        ),
      ),
    );
  }
}
