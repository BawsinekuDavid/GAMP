import 'package:flutter/material.dart';
import 'package:gmarket_app/Endpoints/productsapi.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/components/display_constainer.dart';
import 'package:gmarket_app/components/text_field.dart';
import 'package:gmarket_app/pages/categories/fruits_page.dart';
import 'package:gmarket_app/pages/categories/vegetables_page.dart';

 
 
import '../../models/products_module.dart';
 

class MeatFishPage extends StatelessWidget {
  const MeatFishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: colors,
        title: const Text(
          "Meat & Fish",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Product>>(
          future: ProductsApi().fetchProductsByCategory('Meat & Fish'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final products = snapshot.data ?? [];
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search and Location Row
                  Row(
                    children: [
                      const Text(
                        "Find Fresh Produce",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SearchField(
                          icon: const Icon(Icons.location_on, color: Colors.green),
                          hintText: "Location",
                          bgColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Search Bar Row
                  Row(
                    children: [
                      Expanded(
                        child: SearchField(
                          icon: const Icon(Icons.search, color: Colors.green),
                          hintText: "Search meat & fish...",
                          bgColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      MySearchBtn(
                        lab: "Search",
                        colorState: colors,
                        onPressed: () {},
                        textColorState: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Categories Section
                  const Text(
                    "Categories",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        DynamicBtn(
                          label2: "Fruits",
                          shadowColor2: Colors.grey,
                          textColorState2: Colors.white,
                          colorState2: colors,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FruitsPage()),
                          ),
                        ),
                        const SizedBox(width: 10),
                        DynamicBtn(
                          label2: "Vegetables",
                          shadowColor2: Colors.grey,
                          textColorState2: Colors.white,
                          colorState2: colors,
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const VegetablesPage()),
                          ),
                        ),
                        const SizedBox(width: 10),
                        DynamicBtn(
                          label2: "Meat & Fish",
                          shadowColor2: Colors.grey,
                          textColorState2: Colors.white,
                          colorState2: colors,
                          onPressed: () {}, // Current page, no navigation needed
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Products Near You Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Near You",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "See all",
                          style: TextStyle(
                            fontSize: 18,
                            color: colors,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Products Grid
                  products.isEmpty
                      ? const Center(
                          child: Text(
                            "No meat & fish products available",
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return DisplayContainer(
                              imagePath: product.imageUrl,
                              containerText: Colors.red,
                              numberRate: product.rating,
                              names: product.product,
                              price: product.unitPrice,
                              onPressed: () {
                                // Navigate to product details
                              },
                            );
                          },
                        ),

                  // All Vendors Section
                  const SizedBox(height: 25),
                  const Text(
                    "All Vendors",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  // Add your vendors list here
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}