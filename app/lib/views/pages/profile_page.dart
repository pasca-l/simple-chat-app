import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: Column(
          children: [
            Text("Profile page!!!"),
          ],
        ),
      ),
    );
  }
}