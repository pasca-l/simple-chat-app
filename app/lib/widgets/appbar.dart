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
        child: UserAvatar()
      )
    ],
  );
}

AppBar chatAppBar(String name) {
  return AppBar(
    title: Text("${name}"),
    centerTitle: true,
    elevation: 10,
  );
}