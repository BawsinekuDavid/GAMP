import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/Products/product_page.dart';
import '../../components/text_field.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 150,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Column(
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
            )),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Vendors >",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    product.name,
                    style: TextStyle(
                        color: colors,
                        decoration: TextDecoration.underline,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: 180,
                height: 200, // Increased height to accommodate the text
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors
                      .grey.shade200, // Background color for the container
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center content horizontally
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        product.image,
                        height: 140, // Adjusted height for the image
                        width: 160, // Adjusted width for the image
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(product.name),
                    Text(
                      'Rating: ${product.rating}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey, // Text color for contrast
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
