import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class homeNavigationBar extends StatelessWidget {
  const homeNavigationBar({
    Key? key,
    required this.onIndexChange,
  }) : super(key: key);

  final ValueChanged<int> onIndexChange;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navigationBarItem(
            label: "home",
            icon: Icons.home,
            onTap: () {
              onIndexChange(0);
            }
          ),

          _navigationBarItem(
            label: "message",
            icon: Icons.message,
            onTap: () {
              onIndexChange(1);
            }
          ),

          _navigationBarItem(
            label: "profile",
            icon: Icons.accessibility,
            onTap: () {
              onIndexChange(2);
            }
          ),
        ],
      ),
    );
  }
}

class _navigationBarItem extends StatelessWidget {
  const _navigationBarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
    
  }
}