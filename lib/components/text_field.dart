import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;
  
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText, 
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: false,
      
      decoration: InputDecoration(
         
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.shade100),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.green.shade400)),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}

// ignore: must_be_immutable
class SearchField extends StatelessWidget {
  final String hintText;
  Color? bgColor;
  Icon? icon;

  SearchField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: icon,
          fillColor: bgColor,
          focusColor: colors,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          hintText: hintText,
          suffix: Icon(
            Icons.fitbit,
            color: colors,
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MySearchBtn extends StatelessWidget {
  final String lab;
  Color? colorState;
  Color? textColorState;
  Function()? onPressed;

  MySearchBtn(
      {super.key,
      required this.lab,
      required this.colorState,
      required this.onPressed,
      required this.textColorState});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shadowColor: colors,
          backgroundColor: colorState ?? colors,
        ),
        onPressed: onPressed,
        child: Text(
          lab,
          style: TextStyle(
            color: textColorState ?? colors,
            fontSize: 16,
          ),
        ));
  }
}
