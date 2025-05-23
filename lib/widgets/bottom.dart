import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../utils/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final RxInt selectedIndex;
  final Function(int) onTap;

  BottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        index: selectedIndex.value,
        color: AppColors.primary,
        buttonBackgroundColor: AppColors.accent,
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.category, size: 30, color: Colors.white),
          Icon(Icons.quiz, size: 30, color: Colors.white),
          Icon(Icons.show_chart, size: 30, color: Colors.white),
        ],
        onTap: onTap,
      );
    });
  }
}
