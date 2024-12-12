import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/Orders/track_order_page.dart';

class OrderSucessful extends StatelessWidget {
  const OrderSucessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 250,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 50,
        backgroundColor: colors,
        automaticallyImplyLeading: false,
        title: Center(
          child: Column(
            children: [
              const Text(
                "Order Successful",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Hurray!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    "lib/images/clapping.png",
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
              border: Border.all(
                  style: BorderStyle.solid, color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(30)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            DottedBorder(
              borderType: BorderType.Circle,
              radius: const Radius.circular(20),
              padding: const EdgeInsets.all(15),
              dashPattern: const [6, 3],
              color: colors,
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: colors,
                    size: 100,
                  )),
            ),
            const SizedBox(height: 60),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "SUCCESSFUL",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                const Center(
                  child: Text(
                    "Your order has been placed.Proceed to track your order!",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 60),
                AppBtn(
                  lbl: 'ok',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TrackOrderPage()));
                  },
                  textColorState: Colors.white,
                  colorState: colors,
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
