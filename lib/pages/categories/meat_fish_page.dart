import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';
import 'package:gmarket_app/components/app_btn.dart';
import 'package:gmarket_app/components/display_constainer.dart';
import 'package:gmarket_app/components/text_field.dart';
import 'package:gmarket_app/pages/categories/fruits_page.dart';
import 'package:gmarket_app/pages/categories/vegetables_page.dart';

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
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Find Fresh Produce",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(width: 10),
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

                  // Add a SizedBox for spacing
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SearchField(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.green,
                          ),
                          hintText: "Search",
                          bgColor: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      MySearchBtn(
                        lab: "Search",
                        colorState: colors,
                        onPressed: () {},
                        textColorState: Colors.white,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      DynamicBtn(
                        label2: "Fruits",
                        shadowColor2: Colors.grey,
                        textColorState2: Colors.white70,
                        colorState2: colors,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FruitsPage()));
                        },
                      ),
                      const SizedBox(width: 20),
                      DynamicBtn(
                        label2: "Vegatbles",
                        shadowColor2: Colors.grey,
                        textColorState2: Colors.white70,
                        colorState2: colors,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const VegetablesPage()));
                        },
                      ),
                      const SizedBox(width: 20),
                      DynamicBtn(
                        label2: "Meat & Fish",
                        shadowColor2: Colors.grey,
                        textColorState2: Colors.white70,
                        colorState2: colors,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MeatFishPage()));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Near You",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "See all",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: colors,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Column(
                    children: [
                      Row(
                        children: [
                          DisplayContainer(
                            imagePath: "lib/images/mangos.jpg",
                            containerText: Colors.red,
                            numberRate: 4.0,
                            names: "monasdh",
                            onPressed: null,
                          ),
                          SizedBox(width: 20),
                          DisplayContainer(
                            imagePath: "lib/images/mangos.jpg",
                            containerText: Colors.red,
                            numberRate: 4.0,
                            names: "Banana",
                            onPressed: null,
                          ),
                          SizedBox(width: 20),
                          DisplayContainer(
                            imagePath: "lib/images/mangos.jpg",
                            containerText: Colors.red,
                            numberRate: 4.0,
                            names: "Mango",
                            onPressed: null,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          DisplayContainer(
                            imagePath: "lib/images/mangos.jpg",
                            containerText: Colors.red,
                            numberRate: 4.0,
                            names: "Mango",
                            onPressed: null,
                          ),
                          SizedBox(width: 20),
                          DisplayContainer(
                            imagePath: "lib/images/mangos.jpg",
                            containerText: Colors.red,
                            numberRate: 4.0,
                            names: "Mango",
                            onPressed: null,
                          ),
                          SizedBox(width: 20),
                          DisplayContainer(
                            imagePath: "lib/images/mangos.jpg",
                            containerText: Colors.red,
                            numberRate: 4.0,
                            names: "Mango",
                            onPressed: null,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "All Vendors",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          DisplayContainer(
                            imagePath: "lib/images/mangos.jpg",
                            containerText: Colors.red,
                            numberRate: 4.0,
                            names: "Mango",
                            onPressed: null,
                          ),
                          SizedBox(width: 20),
                          DisplayContainer(
                            imagePath: "lib/images/mangos.jpg",
                            containerText: Colors.red,
                            numberRate: 4.0,
                            names: "Mango",
                            onPressed: null,
                          ),
                          SizedBox(width: 20),
                          DisplayContainer(
                            imagePath: "lib/images/mangos.jpg",
                            containerText: Colors.red,
                            numberRate: 4.0,
                            names: "Mango",
                            onPressed: null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  //bottom nav bar
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
