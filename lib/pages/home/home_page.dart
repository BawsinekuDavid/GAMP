import 'package:flutter/material.dart';
import 'package:gmarket_app/components/text_field.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/db/db_helper.dart';
import 'package:gmarket_app/pages/Products/product_details_page.dart';
import 'package:gmarket_app/pages/Products/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar:AppBar(
  automaticallyImplyLeading: false,
  toolbarHeight: 200,
  title: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Find Fresh Produce",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // Current Location Button
          IconButton(
            icon: const Row(
              children: [
                Icon(Icons.location_on, color: Colors.green),
                SizedBox(width: 4),
                Text("Current Location", style: TextStyle(color: Colors.green)),
              ],
            ),
            onPressed: () {
              // Add location fetching logic here
            },
          ),
        ],
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: SearchField(
              icon: const Icon(Icons.search, color: Colors.green),
              hintText: "Search for produce...",
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
      const SizedBox(height: 25),
      const Row(
        children: [
          Text(
            "Categories",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(height: 15),
    ],
  ),
  bottom: TabBar(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    indicatorSize: TabBarIndicatorSize.tab,
    labelColor: Colors.white,
    unselectedLabelColor: Colors.black,
    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
    indicator: BoxDecoration(
    shape: BoxShape.rectangle,
      color: colors,
      borderRadius: BorderRadius.circular(10),
    ),
    tabs: const [
      Tab(text: "Fruits"),
      Tab(text: "Vegetables"),
      Tab(text: "Meat & Fish"),
    ],
  ),
),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              ProductGrid(category: 'Fruits'),
              ProductGrid(category: 'Vegetables'),
              ProductGrid(category: 'Meat & Fish'),
            ],
          ),
        ),
      ),
    );
 
  }
}

class ProductGrid extends StatelessWidget {
  final String category;
  const ProductGrid({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: DbHelper().getProductsByCategory(category),
      builder: (context, snapshot) {
        // Debug print to see what's being returned
        print('Snapshot data: ${snapshot.data}');
        print('Snapshot error: ${snapshot.error}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error.toString()}"),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("No Products found"),
              ElevatedButton(
                onPressed: () async {
                  await populateDatabase();
                  //setState(() {}); // Refresh the widget
                },
                child: const Text("Reload Data"),
              ),
            ],
          );
        }

        final products = snapshot.data!;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.90,
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
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    // ignore: unnecessary_null_comparison
                    child: product.image != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                              product.image,
                              fit: BoxFit.cover,
                              
                            ),
                        )
                        : const Icon(Icons.image_not_supported),
                  ),

                  
                  const SizedBox(height: 5),

                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(color: Colors.red),
                      ),
                       Text("GHC ${product.price}",
                  style: TextStyle(color: colors),),
                      
                    ],
                  ),
                   Text(
                        'rating: ${product.rating}',
                        style: TextStyle(color: colors),
                      ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
