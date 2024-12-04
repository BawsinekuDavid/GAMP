import 'package:flutter/material.dart';
import 'package:gmarket_app/components/text_field.dart';
import 'package:gmarket_app/constant.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: FittedBox(
          child: Text("Find Fresh Produce",
          style: TextStyle(fontSize: 20),),
        ),
        
        actions: [
          SearchField(icon: Icon(Icons.location_on, color: colors,), hintText: "loaction", bgColor: Colors.green)
        ],

      ),

      body: SearchField(icon: Icon(Icons.search, color: colors,), hintText: "search", bgColor: Colors.grey.shade300),
       
    );
  }
}