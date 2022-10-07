import 'package:app/modules/database.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/widget_list.dart';

AppBar mainAppBar() {
  return AppBar(
    title: Text("simple chat app"),
    centerTitle: true,
    elevation: 10,
  );
}

AppBar userAppBar() {
  return AppBar(
    title: Text("simple chat app"),
    centerTitle: true,
    elevation: 10,
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 16),
        child: UserAvatar(),
      )
    ],
  );
}