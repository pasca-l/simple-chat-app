import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
    
            Text("Profile page!!!"),
    
          ],
        ),
      ),
    );
  }
}