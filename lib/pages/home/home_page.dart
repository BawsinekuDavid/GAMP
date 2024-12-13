import 'package:flutter/material.dart';
import 'package:gmarket_app/components/text_field.dart';
import 'package:gmarket_app/constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
              Tab(
                child: Text("Fruits")),
              Tab(
                child: Text("Vegatable"),
              ),
              Tab(
                child: Text("Meat & Fish"),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 10,),
                    
                    itemCount: 15,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child:  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color:  colors
                      ),
                    )
                  );
                }),
            const Text("Vegetables"),
            const Text("Meat and Fish")
          ],
        ),
      ),
    );

    //bottom nav bar
  }
}
