import 'package:flutter/material.dart';
import 'package:app/widgets/appbar.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(),
      body: Container(
        child: Text("HOME!!!!!!!!"),
      ),
    );
  }
}