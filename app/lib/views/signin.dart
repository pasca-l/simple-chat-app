import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/modules/auth.dart';
import 'package:app/views/signup.dart';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/form.dart';
import 'package:app/widgets/snackbar.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Authentication _authMthd = Authentication();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController _emailTxtCtrl = TextEditingController();
  TextEditingController _passwordTxtCtrl = TextEditingController();

  @override
  void dispose() {
    _emailTxtCtrl.dispose();
    _passwordTxtCtrl.dispose();
    super.dispose();
  }

  Future signIn() async {
    if (_formKey.currentState!.validate()) {
      setState( () {
        _isLoading = true;
      });

      await _authMthd.passwordSignIn(
        _emailTxtCtrl.text.trim(),
        _passwordTxtCtrl.text.trim()
      ).then( (result) {

        setState( () {
          _isLoading = false;
        });

        if (result == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar("No user found for that email.")
          );
        } else if (result == 'user-disabled') {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar("User disabled for that email.")
          );
        } else if (result == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar("Wrong password provided for that user.")
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

              // email and password
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    authForm(_emailTxtCtrl, "email"),
                    SizedBox(height: 8),
                    authForm(_passwordTxtCtrl, "password"),
                    SizedBox(height: 8),
                  ],
                ),
              ),

              // signin button
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  signIn();
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
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                ),
              ),

              // to sign up page
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp())
                      );
                    },
                    child: Text(
                      "Sign up",
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
