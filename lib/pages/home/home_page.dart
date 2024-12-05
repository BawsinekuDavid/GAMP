import 'package:flutter/material.dart';
import 'package:gmarket_app/components/text_field.dart';
import 'package:gmarket_app/constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
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
                      icon: const Icon(Icons.location_on,
                      color:Colors.green,),
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
                        icon: const Icon(Icons.search, color: Colors.green,),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
