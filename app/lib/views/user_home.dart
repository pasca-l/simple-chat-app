import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/drawer.dart';
import 'package:app/views/test.dart';


class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
              Text("${user.email!} HOME!!!!!!!!"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TestPage())
                  );
                },
                child: Text("press here"),
              ),
            ],
          ),
        ),
      ),
    );

  }
}