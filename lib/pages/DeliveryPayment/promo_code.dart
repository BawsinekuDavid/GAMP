import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:gmarket_app/constant.dart';

import 'package:provider/provider.dart';

import '../../models/deliverypaymentstate.dart';

class PromoCodeSection extends StatefulWidget {
  const PromoCodeSection({super.key});

  @override
  State<PromoCodeSection> createState() => _PromoCodeSectionState();
}

class _PromoCodeSectionState extends State<PromoCodeSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: colors,
      borderType: BorderType.RRect,
      radius: const Radius.circular(7),
      strokeWidth: 1,
      dashPattern: const [6, 3],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Add Promo Code",
                hintStyle: TextStyle(fontSize: 20, color: colors),
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(colors),
            ),
            onPressed: () {
              final state =
                  Provider.of<DeliveryPaymentState>(context, listen: false);
              if (_controller.text.isNotEmpty) {
                state.applyDiscount(1.00); // GHC 1.00 discount
              } else {
                state.resetDiscount();
              }
            },
            child: const Text(
              "Apply",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
