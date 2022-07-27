import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/main.dart';


class menuDrawer extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Container(
            height: 150,
            child: DrawerHeader(
              child: Text("Logged in as ${user.email!}"),
            ),
          ),

          ListTile(
            title: Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut()
              .then( (value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp())
                );
              });
            },
          ),
        ],
      ),
    );

  }
}