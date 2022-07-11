import 'package:flutter/material.dart';

TextFormField authForm(TextEditingController txtCtrl, String hintText) {
  return TextFormField(
    controller: txtCtrl,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.black45,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlue)
      ),
    ),
    validator: (val) {
      if (val == null || val.isEmpty) {
        return "Please enter some text";
      } else if (hintText == "email") {
        return 
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+" + 
                   r"@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
            null :
            "Please enter an email address.";
      } else if (hintText == "password") {
        return 
            val.length > 6 ?
            null :
            "Enter password of 6+ characters.";
      }
    },
    obscureText: (hintText == "password") ? true : false,
  );
}