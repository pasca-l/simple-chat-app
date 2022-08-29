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

  int pageIndex = 0;
  final pages = [
    HomePage(),
    MessagePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userAppBar(),
      drawer: menuDrawer(),
      bottomNavigationBar: _homeNavigationBar(
        selectedPage: pageIndex,
        onTap: (int index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
      body: pages.elementAt(pageIndex),
    );
  }
}

class _homeNavigationBar extends StatelessWidget {
  const _homeNavigationBar({
    Key? key,
    required this.selectedPage,
    required this.onTap,
  }) : super(key: key);

  final int selectedPage;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: "message",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: "profile",
          ),
        ],
        currentIndex: selectedPage,
        selectedItemColor: Colors.amber[800],
        onTap: onTap,
    );
  }
}
