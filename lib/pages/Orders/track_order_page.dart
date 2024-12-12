import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: AppBar(
          toolbarHeight: 250,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 50,
          backgroundColor: colors,
          automaticallyImplyLeading: false, // Disable default placement
          flexibleSpace: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 80), // Add some space for the icon
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              "lib/images/mangos.jpg",
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "SeaDelights",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Order ID: 289635AGB",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 50),
                      ],
                    ),
                  ],
                ),
              ),
               Positioned(
                top: 35,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Track Orders",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            BulletedList(
              listItems: const [
                Text(
                  "Vendor has confirmed order",
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  "Preparing Order",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Looking for Courier",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Courier has been found",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Courier is on the way to you",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Order accepted",
                  style: TextStyle(fontSize: 25),
                ),
              ],
              bulletColor: colors,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(child: BottomNavBar()),
    );
  }
}
