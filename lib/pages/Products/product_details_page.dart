import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/models/cart_provider.dart';

import 'package:gmarket_app/pages/Products/product_page.dart';
import 'package:provider/provider.dart';
import '../../components/app_btn.dart';
import '../../components/text_field.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _itemCount = 0;

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        
        backgroundColor: colors,
        clipBehavior: Clip.none,
         content: const Text("Successfully added to cart", style: TextStyle(color: Colors.white, fontSize: 16),textAlign: TextAlign.center,),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pop(context);
              },
              icon: const Icon(Icons.done, color: Colors.white,))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 150,
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
                    widget.product.name,
                    style: TextStyle(
                        color: colors,
                        decoration: TextDecoration.underline,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  widget.product.image,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Text(
                  //   widget.product.name,
                  //   style: const TextStyle(fontSize: 25),
                  // ),

                  Text("Ghc: ${widget.product.price}",style: const TextStyle(fontSize: 25),),
                  Text(
                    'Rating: ${widget.product.rating}',
                    style: TextStyle(
                      fontSize: 20,
                      color: colors, // Text color for contrast
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle),
                    color: colors,
                    iconSize: 50,
                    onPressed: () {
                      setState(() {
                        if (_itemCount > 0) _itemCount--;
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  Text(
                    _itemCount.toString(),
                    style: TextStyle(color: colors, fontSize: 20),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _itemCount++;
                      });
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: colors,
                      size: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              AppBtn(
                lbl: "Add To Cart",
                colorState: colors,
                textColorState: Colors.white,
                onPressed: () {
                  final cartProvider =
                      Provider.of<CartProvider>(context, listen: false);
                  cartProvider.addToCart(
                    Product(
                      image: widget.product.image,
                      name: widget.product.name,
                      category: widget.product.category,
                      rating: widget.product.rating,
                      quantity: _itemCount > 0 ? _itemCount : 1,
                      price: widget.product.price,
                    ),
                  );

                  _showSuccessDialog(context);
                },
              ),
            ],
          )),
    );
  }
}
