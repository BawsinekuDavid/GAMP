import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/PROVIDERS/cart_provider.dart';
import 'package:provider/provider.dart';
import '../../components/app_btn.dart';
import '../../components/text_field.dart';
import '../../models/products_module.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _itemCount = 1;
  bool _isAddingToCart = false;

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
        ),
      ),
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
                  widget.product.product,
                  style: TextStyle(
                    color: colors,
                    decoration: TextDecoration.underline,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  // Use Image.network for URLs
                  widget.product.imageUrl,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                        Icons.error); // Fallback widget for errors
                  },
                )),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Ghc: ${widget.product.unitPrice}",
                  style: const TextStyle(fontSize: 25),
                ),
                Text(
                  'Rating: ${widget.product.rating}',
                  style: TextStyle(
                    fontSize: 20,
                    color: colors,
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
                      if (_itemCount > 1) _itemCount--;
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
            const SizedBox(height: 50),
            _isAddingToCart
                ? CircularProgressIndicator(color: colors)
                : AppBtn(
                    lbl: "Add To Cart",
                    colorState: colors,
                    textColorState: Colors.white,
                    onPressed: () async {
                      if (_itemCount == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please select at least one item')),
                        );
                        return;
                      }

                      setState(() => _isAddingToCart = true);

                      try {
                        final cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        await cartProvider.addToCart(
                          Product(
                            id: widget.product.id,
                            product: widget.product.product,
                           
                            unitPrice: widget.product.unitPrice,
                            imageUrl: widget.product.imageUrl,
                            category: widget.product.category,
                            rating: widget.product.rating,
                            quantity: _itemCount, // Use selected quantity
                            isApproved: widget.product.isApproved,
                          ),
                        );
                        Fluttertoast.showToast(
                            msg: "Added to Cart",
                            textColor: Colors.white,
                            backgroundColor: colors,
                            webPosition: "top");
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}')),
                        );
                      } finally {
                        if (mounted) {
                          setState(() => _isAddingToCart = false);
                        }
                      }
                      Navigator.pop(context);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
