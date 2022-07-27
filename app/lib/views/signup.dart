import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/modules/auth.dart';
import 'package:app/views/signin.dart';
import 'package:app/views/meta.dart';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/form.dart';
import 'package:app/widgets/snackbar.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Authentication _authMthd = Authentication();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController _usernameTxtCtrl = TextEditingController();
  TextEditingController _emailTxtCtrl = TextEditingController();
  TextEditingController _passwordTxtCtrl = TextEditingController();

  @override
  void dispose() {
    _usernameTxtCtrl.dispose();
    _emailTxtCtrl.dispose();
    _passwordTxtCtrl.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (_formKey.currentState!.validate()) {
      setState( () {
        _isLoading = true;
      });

      await _authMthd.passwordSignUp(
        _emailTxtCtrl.text.trim(),
        _passwordTxtCtrl.text.trim()
      ).then( (result) {

        setState( () {
          _isLoading = false;
        });

        if (result == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar("The password provided is too weak.")
          );
        } else if (result == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar("The account already exists for that email.")
          );
        } else if (result == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar("Some problem occured, please try again.")
          );
        }

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(),
      body: _isLoading ?
            Container(child: Center(child: CircularProgressIndicator())) :
            SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [

              // username, email and password
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    authForm(_usernameTxtCtrl, "username"),
                    SizedBox(height: 8),
                    authForm(_emailTxtCtrl, "email"),
                    SizedBox(height: 8),
                    authForm(_passwordTxtCtrl, "password"),
                    SizedBox(height: 8),
                  ],
                ),
              ),

              // signup button
              SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  await signUp()
                  .then( (value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Meta())
                    );
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff007ef4),
                        Color(0xff2a75bc),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                ),
              ),

              // to sign in page
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Already registered? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
