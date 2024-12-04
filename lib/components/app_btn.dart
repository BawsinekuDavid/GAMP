import 'package:flutter/material.dart';

import '../constant.dart';

// ignore: must_be_immutable
class AppBtn extends StatelessWidget {
  final String lbl;
  Color? textColorState;
  Color? colorState;
  Function() onPressed;
   AppBtn({super.key, required this.lbl, required this.colorState, required this.textColorState, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
       style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
      shadowColor: colors,
      backgroundColor: colorState ?? colors,
       ),
       child: Text(lbl,
       style:TextStyle(color: textColorState ?? colors,
       fontSize: 25,
       fontWeight: FontWeight.bold),
      
        
       ), 
       
         
        );
  }
}