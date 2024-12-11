import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';

class CartCointainers extends StatelessWidget {
  final String name;
  final Icon;
  final String subname;
  final tailIcon;

  const CartCointainers(
      {super.key,
      required this.name,
      this.Icon,
      required this.subname,
      this.tailIcon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon,
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
