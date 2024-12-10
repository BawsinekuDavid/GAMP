import 'package:flutter/material.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/components/bottom_nav_bar.dart';
import 'package:gmarket_app/components/display_constainer.dart'; // Assuming this is your DisplayContainer widget
import '../../components/text_field.dart';
import '../../constant.dart'; // Assuming this is your custom TextField widget

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: colors,
        title: const Text("PRODUCTS", style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // Wrap the search bar and grid in a Column
          children: [
            const SizedBox(height: 20), // Add some spacing after the AppBar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Find Fresh Produce",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
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

            SizedBox(height: 20),
            
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Vendors\>", style: TextStyle(fontSize: 20), ),

                Text("EcoGreen", style: TextStyle(color: colors,decoration: TextDecoration.underline, fontSize: 20),)
              ],
            ),

            const SizedBox(
                height: 30), // Add some spacing between search and grid
            Expanded(
              // Use Expanded to allow the GridView to take up remaining space
              flex: 1,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 15,
                children: [
                  ProductConatiner(
                    // Corrected typo here
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                  ProductConatiner(
                    // Corrected typo here
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                  ProductConatiner(
                    // Corrected typo here
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                  ProductConatiner(
                    // Corrected typo here
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                   ProductConatiner(
                    // Corrected typo here
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                  ProductConatiner(
                    // Corrected typo here
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                   ProductConatiner(
                    // Corrected typo here
                    price: "2.0",
                    labels: "cow",
                    weight: "50kg",
                    imagePath: "lib/images/mangos.jpg",
                  ),
                  ProductConatiner(
                    // Corrected typo here
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

      // bottomNavigationBar: BottomNavBar(),
      
      // bottomNavigationBar: SizedBox(
      //       height: size.height * 0.07,
      //       child: AppBtn(lbl: 'tes', 
      //       colorState: Colors.red, 
      //       textColorState: Colors.white, 
      //       onPressed: (){})
      //      ),
      
    );
  }
}
