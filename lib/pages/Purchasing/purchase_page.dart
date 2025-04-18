import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/Cart/delivery_payment.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors),
        title: Text(
          "EcoGreen",
          style: TextStyle(color: colors),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/tomato.png',
              width: 250,
              height: 250,
            ),
            const SizedBox(height: 50), // Add spacing between image and text
            const Text('Price: Ghc 36',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Labels: tomato', style: TextStyle(fontSize: 16, ),),
             const SizedBox(height: 10),
            const Text('Weight: 5kg',style: TextStyle(fontSize: 16, )),
             const SizedBox(height: 10),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                
                IconButton(
                icon: const Icon(Icons.remove_circle),
                  color: colors, onPressed: () { setState(() {
                    _itemCount --;
                  });},
                ),
                 const SizedBox(width: 20),
                Text(_itemCount.toString(),style: TextStyle(color: colors), ),
                 const SizedBox(width: 20),
                 IconButton(onPressed: (){setState(() {
                   _itemCount ++;
                 });}, icon: Icon(Icons.add_circle, color: colors,))
              ],
            ),

            const SizedBox(
              height: 50,
            ),
            AppBtn(
                lbl: "Add To Cart",
                colorState: colors,
                textColorState: Colors.white,
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>const DeliveryPayment()));})
          ],
        ),
      ),
    );
  }
}
