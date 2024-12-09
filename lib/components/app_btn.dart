import 'package:flutter/material.dart';

import '../constant.dart';

// ignore: must_be_immutable
class AppBtn extends StatelessWidget {
  final String lbl;
  Color? textColorState;
  Color? colorState;
  Function() onPressed;
  AppBtn(
      {super.key,
      required this.lbl,
      required this.colorState,
      required this.textColorState,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
        shadowColor: colors,
        backgroundColor: colorState ?? colors,
      ),
      child: Text(
        lbl,
        style: TextStyle(
            color: textColorState ?? colors,
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

// ignore: must_be_immutable
class DynamicBtn extends StatelessWidget {
  Color? colorState2;
  Color? shadowColor2;
  final String label2;
  Color? textColorState2;
  Function()? onPressed;

  DynamicBtn(
      {super.key,
      required this.label2,
      required this.shadowColor2,
      required this.textColorState2,
      required this.colorState2,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shadowColor: shadowColor2,
        backgroundColor: colorState2 ?? colors,
      ),
      child: Text(
        label2,
        style: TextStyle(
            fontSize: 20, 
            fontWeight: FontWeight.bold,
             color: textColorState2),
      ),
    );
  }
}
