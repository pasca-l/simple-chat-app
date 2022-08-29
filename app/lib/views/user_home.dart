import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/modules/module_list.dart';
import 'package:app/views/view_list.dart';
import 'package:app/widgets/widget_list.dart';


class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final user = FirebaseAuth.instance.currentUser!;

  final pages = [
    HomePage(),
    MessagePage(),
    ProfilePage(),
  ];
  final ValueNotifier<int> pageIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: userAppBar(),
      drawer: menuDrawer(),
      bottomNavigationBar: _homeNavigationBar(
        onIndexChange: (index) {
          pageIndex.value = index;
        }
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, int value, child) {
          return pages[value];
        },
      ),
    );

  }
}

class _homeNavigationBar extends StatelessWidget {
  const _homeNavigationBar({
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