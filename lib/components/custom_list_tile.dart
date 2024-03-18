import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool showToggle;
  final bool toggleValue;
  final ValueChanged<bool>? onToggle;
  final VoidCallback? onTap;
  final Color? toggleColor;
  final Color? toggleColorBackground;

  const CustomListTile({
    required this.title,
    this.subtitle,
    this.showToggle = false,
    this.toggleValue = false,
    this.onToggle,
    this.onTap,
    this.toggleColor,
    this.toggleColorBackground,
  });


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: showToggle
          ? Switch(
        activeColor: toggleColor,
        activeTrackColor: toggleColorBackground,
        value: toggleValue,
        onChanged: onToggle,
      )
          : null,
    );
  }
}
