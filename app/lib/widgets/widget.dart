import 'package:flutter/material.dart';

AppBar appBarMain(BuildContext context) {
  return AppBar(
    title: Text("simple chat app"),
    centerTitle: true,
    elevation: 10,
  );
}

InputDecoration textInputFieldDeco(String hintText){
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.black45,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlue)
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green),
    ),
  );
}

TextStyle textInputFieldStyle(){
  return TextStyle(
    color: Colors.black,
    fontSize: 16,
  );
}
