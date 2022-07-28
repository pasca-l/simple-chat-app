import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/modules/module_list.dart';
import 'package:app/views/view_list.dart';
import 'package:app/widgets/widget_list.dart';


class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: mainAppBar(),
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