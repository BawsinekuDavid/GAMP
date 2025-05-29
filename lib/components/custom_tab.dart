// lib/components/custom_tab_bar.dart
import 'package:flutter/material.dart';

import '../constant.dart';

class CustomTabBar extends StatelessWidget {
  final int currentIndex;
  final List<String> tabs;
  final ValueChanged<int> onTap;

  const CustomTabBar({
    super.key,
    required this.currentIndex,
    required this.tabs,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) {
          final isSelected = index == currentIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: isSelected ? colors : Colors.transparent,
                ),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}