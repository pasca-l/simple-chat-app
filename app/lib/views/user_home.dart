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
      bottomNavigationBar: homeNavigationBar(
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