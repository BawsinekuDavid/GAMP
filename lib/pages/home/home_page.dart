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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 200,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Find Fresh Produce",
                    style: TextStyle(fontSize: 20),
                  ),
                  SearchField(
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                    hintText: "Location",
                    bgColor: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SearchField(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.green,
                    ),
                    hintText: "Search",
                    bgColor: Colors.white,
                  ),
                  MySearchBtn(
                    lab: "Search",
                    colorState: colors,
                    onPressed: () {},
                    textColorState: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
          bottom: TabBar(
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              color: Colors.black,
            ),
            indicator: BoxDecoration(
                color: colors,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10)),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: colors,
            tabs: const [
              Tab(child: Text("Fruits")),
              Tab(
                child: Text("Vegatable"),
              ),
              Tab(
                child: Text("Meat & Fish"),
              )
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

    //bottom nav bar
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
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
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
                    width: 120,
                    height: 100,
                    color: Colors.grey[200],
                    // ignore: unnecessary_null_comparison
                    child: product.image != null
                        ? Image.asset(
                            product.image,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.name,
                    style: const TextStyle(color: Colors.red),
                  ),
                  Text(
                    '${product.rating}',
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
