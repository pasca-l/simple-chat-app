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

  int pageIndex = 1;
  final pages = [
    HomePage(),
    MessagePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userAppBar(),
      floatingActionButton: HomeActionButton(selectedPage: pageIndex),
      drawer: menuDrawer(),
      bottomNavigationBar: HomeNavigationBar(
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

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({
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

class HomeActionButton extends StatelessWidget {
  const HomeActionButton({
    Key? key,
    required this.selectedPage,
  }) : super(key: key);

  final int selectedPage;

  Icon _pageIcon(int selectedPage) {
    switch (selectedPage) {
      case 0:
        return Icon(Icons.home);
      case 1:
        return Icon(Icons.add);
      case 2:
        return Icon(Icons.send);
      default:
        return Icon(Icons.close);
    }
  }

  VoidCallback _buttonFunction(BuildContext context, int selectedPage) {
    switch (selectedPage) {
      case 0:
        return () {};
      case 1:
        return () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatRoom(
              chatroom: Database.createNewChatroom(),
            ))
          );
        };
      case 2:
        return () {};
      default:
        return () {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _buttonFunction(context, selectedPage),
      child: _pageIcon(selectedPage),
    );
  }
}