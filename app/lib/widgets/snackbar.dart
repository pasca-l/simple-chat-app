import 'package:flutter/material.dart';

void errorSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: "OK",
        onPressed: () {},
      ),
    )
  );
}