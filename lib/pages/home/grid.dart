import 'package:flutter/material.dart';

import '../../Endpoints/productsapi.dart';
import '../../constant.dart';
import '../Products/product_details_page.dart';
import '../../models/products_module.dart';

class ProductGrid extends StatefulWidget {
  final String category;
  const ProductGrid({super.key, required this.category});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final ProductsApi _productsApi = ProductsApi();
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    setState(() {
      _futureProducts = widget.category == 'All'
          ? _productsApi.fetchAllProducts()
          : _productsApi.fetchProductsByCategory(widget.category);
    });
  }

  Future<void> _refreshProducts() async {
    _loadProducts();
  }
 @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshProducts,
      child: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Error: ${snapshot.error.toString()}"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _refreshProducts,
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products available"));
          }
          
          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.0, // Slightly taller cards
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage(product: product),
                  ),
                ),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image with Aspect Ratio
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: AspectRatio(
                          aspectRatio: 2,
                          child: product.imageUrl.isNotEmpty
                              ? Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                    
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      
                      
                      // Product Details
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.product,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 1,
                                ),
                                
                                const SizedBox(height: 4),
                                
                                // Category Tag
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colors.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    product.category,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: colors,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Price and Rating Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Price
                              
                                Text(
                                  "Ghc ${product.unitPrice}"
                                ),
                                // Rating
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      product.rating.toStringAsFixed(1),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            
                            // Stock Status
                            const SizedBox(height: 4),
                            // Text(
                            //   product.stock > 0
                            //       ? "In Stock (${product.stock})"
                            //       : "Out of Stock",
                            //   style: TextStyle(
                            //     fontSize: 10,
                            //     color: product.stock > 0
                            //         ? Colors.green
                            //         : Colors.red,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
