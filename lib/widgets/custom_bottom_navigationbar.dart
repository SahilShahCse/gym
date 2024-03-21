import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onNavItemPressed;
  final List<IconData> customIcons; // List of custom icons

  const CustomBottomNavBar({
    required this.currentIndex,
    required this.onNavItemPressed,
    required this.customIcons,
  });

  @override
  Widget build(BuildContext context) {
    assert(customIcons.length == 4, 'Custom icons list should have exactly 4 icons.');

    return SafeArea(
      top: false,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (int index = 0; index < 4; index++)
              _buildBottomNavItem(customIcons[index], index),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: currentIndex == index ? Colors.purple : Colors.grey,
      ),
      onPressed: () => onNavItemPressed(index),
    );
  }
}