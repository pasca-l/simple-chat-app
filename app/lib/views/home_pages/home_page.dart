import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/views/view_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
    
            Text("${user.email!} HOME!!!!!!!!"),
    
          ],
        ),
      ),
    );
  }
}