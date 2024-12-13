import 'package:flutter/material.dart';
import 'package:gmarket_app/components/display_constainer.dart'; // Assuming this is your DisplayContainer widget
import '../../components/text_field.dart';
import '../../constant.dart'; // Assuming this is your custom TextField widget

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: colors,
        title: const Text(
          "PRODUCTS",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Find Fresh Produce",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    SearchField(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.green,
                      ),
                      hintText: "Search",
                      bgColor: Colors.white,
                    ),
                    const SizedBox(width: 30),
                    MySearchBtn(
                      lab: "Search",
                      colorState: colors,
                      onPressed: () {},
                      textColorState: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Vendors>",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  "EcoGreen",
                  style: TextStyle(
                      color: colors,
                      decoration: TextDecoration.underline,
                      fontSize: 20),
                )
              ],
            ),
            const SizedBox(height: 30),
            // Wrap the GridView in Expanded without additional wrapping
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 15,
                children: const [
                  ProductConatiner(
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                  ProductConatiner(
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                  ProductConatiner(
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                  ProductConatiner(
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                  ProductConatiner(
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                  ProductConatiner(
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
