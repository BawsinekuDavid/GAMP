import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';

class CartCointainers extends StatelessWidget {
  final String name;
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  final String subname;
  // ignore: prefer_typing_uninitialized_variables
  final tailIcon;
  

  const CartCointainers(
      {super.key,
      required this.name,
      this.icon,
      required this.subname,
      this.tailIcon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(name),
      subtitle: Text(subname),
      subtitleTextStyle: TextStyle(color: Colors.grey[600]),
      titleTextStyle: const TextStyle(color: Colors.black),
      iconColor: colors,
      tileColor: Colors.white,
      trailing: tailIcon,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
    );
  }
}
