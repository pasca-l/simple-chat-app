import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/drawer.dart';


class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: appBarMain(),
      drawer: menuDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text("${user.email!} Next page!!!"),
            ],
          ),
        ),
      ),
    );

  }
}