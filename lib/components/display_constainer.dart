import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/pages/Products/product_page.dart';
import 'package:gmarket_app/pages/Purchasing/purchase_page.dart';

// ignore: must_be_immutable
class DisplayContainer extends StatelessWidget {
  final String imagePath;
  final double numberRate;
  final String names;
  final Color containerText;
  final Function? onPressed;

  // Constructor
  const DisplayContainer(
      {super.key,
      required this.imagePath,
      required this.containerText,
      required this.numberRate,
      required this.names,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      height: 140,
      child: Column(
        children: [
          Container(
            width: 120,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(15)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ProductPage()));
                },
                child: Image.asset(
                  imagePath,
                  width: 120,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                names,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
              const SizedBox(width: 20),

              Text(
                numberRate.toString(),
                style: TextStyle(color: colors),
              ),

//           RatingBar.builder(
//    initialRating: 3,
//    minRating: 1,
//    direction: Axis.horizontal,
//    allowHalfRating: true,
//    itemCount: 5,
//    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//    itemBuilder: (context, _) => Icon(
//      Icons.star,
//      color: Colors.amber,
//    ),
//    onRatingUpdate: (rating) {
//      print(rating);
//    },
// )
            ],
          ),
        ],
      ),
    );
    // Text positioned at the bottom
  }
}

class ProductConatiner extends StatelessWidget {
  final String price;
  final String labels;
  final String weight;
  final String imagePath;
  final Function()? onPressed;

  const ProductConatiner({
    super.key,
    required this.price,
    required this.labels,
    required this.weight,
    required this.imagePath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    
      width: 150,
      height: 200,
      padding: const EdgeInsets.all(10), // Add padding for better spacing
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200, // Added background color for better contrast
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const PurchasePage()));
              },
              child: Image.asset(
                imagePath,
                width: 150,
                height: 100, // Fixed height for image
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10), // Add spacing between image and text
          Text('Price: Ghc $price',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('Labels: $labels'),
          Text('Weight: $weight'),
        ],
      ),
    );
  }
}
