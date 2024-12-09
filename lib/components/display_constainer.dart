import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gmarket_app/constant.dart';

// ignore: must_be_immutable
class DisplayContainer extends StatelessWidget {
  final String imagePath;
  final double numberRate;
  final String names;
  final Color containerText;

  // Constructor
  const DisplayContainer({
    super.key,
    required this.imagePath,
    required this.containerText,
    required this.numberRate,
    required this.names,
  });

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
              child: Image.asset(
                imagePath,
                width: 120,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                names,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            const  SizedBox(width: 20),

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
