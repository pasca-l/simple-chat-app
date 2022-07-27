import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/views/signin.dart';
import 'package:app/views/user_home.dart';


class Meta extends StatelessWidget {
  const Meta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return UserHome();
          } else {
            return SignIn();
          }
        },
      ),
    );
  }
}