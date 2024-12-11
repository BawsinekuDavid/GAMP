import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/components/cart_cointainers.dart';
import 'package:gmarket_app/pages/Orders/order_sucessful.dart';

import '../../constant.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors),
        title: Center(
          child: Text(
            "Delivery and Payment",
            style: TextStyle(color: colors, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 500,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text("Self Pickup"),
                    Container(
                      width: 200,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          "Delivery",
                          style: TextStyle(
                              color: colors, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const CartCointainers(
                Icon: Icon(Icons.watch_later_outlined),
                name: "Products",
                subname: "1x 1kg Read Apples GHC2.00",
                tailIcon: Icon(Icons.add_circle),
              ),
              const SizedBox(height: 20),
              const CartCointainers(
                Icon: Icon(Icons.location_searching),
                name: "Address",
                subname: "234, Nii Ayiksi St",
                tailIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              const CartCointainers(
                Icon: Icon(Icons.person),
                name: "Contact",
                subname: "+233 551015625",
                tailIcon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const CartCointainers(
                Icon: Icon(Icons.watch_later_outlined),
                name: "Delivery Time",
                subname: "As soon as possible",
                tailIcon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const CartCointainers(
                Icon: Icon(Icons.watch_later_outlined),
                name: "Payment Option",
                subname: "Cash",
                tailIcon: Icon(Icons.arrow_forward_ios, color: Colors.grey),
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
                child: Container(
                  width: 500,
                  height: 60,
                  color:
                      Colors.grey.shade100, // Inner container background color
                  alignment: Alignment.center,
                  child: Text(
                    "Add Promo Code",
                    style: TextStyle(
                        color: colors,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sub Total"),
                            Text("Ghc 5.00"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery: "),
                            Text("Ghc 2.00"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total: "),
                            Text(
                              "Ghc 7.00",
                              style: TextStyle(fontSize: 16, color: colors),
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
                                    builder: (context) => OrderSucessful()));
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
    );
  }
}
