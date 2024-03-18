import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onNavItemPressed;

  const CustomBottomNavBar({
    required this.currentIndex,
    required this.onNavItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildBottomNavItem(Icons.people, 0),
            _buildBottomNavItem(Icons.fitness_center, 1),
            _buildBottomNavItem(Icons.brunch_dining, 2),
            _buildBottomNavItem(Icons.payment, 3),
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
