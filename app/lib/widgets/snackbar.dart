import 'package:flutter/material.dart';

SnackBar errorSnackBar(String msg) {
  return SnackBar(
    content: Text(msg),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: "OK",
      onPressed: () {},
    ),
  );
}