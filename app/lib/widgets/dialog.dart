import 'package:flutter/material.dart';

Future? emailSentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Email sent!"),
        content: Text("Please check email for password reset."),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
        ],
      );
    }
  );
}