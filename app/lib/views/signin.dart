import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/modules/auth.dart';

import 'package:app/views/signup.dart';

import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/form.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _emailTxtCtrl = TextEditingController();
  final _passwordTxtCtrl = TextEditingController();

  bool _isLoading = false;
  bool _resetPassField = false;

  @override
  void dispose() {
    _emailTxtCtrl.dispose();
    _passwordTxtCtrl.dispose();
    super.dispose();
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
                  if (_formKey.currentState!.validate()) {
                    setState( () {
                      _isLoading = true;
                    });
                    signIn(
                      context,
                      _emailTxtCtrl.text.trim(),
                      _passwordTxtCtrl.text.trim()
                    );
                    setState( () {
                      _isLoading = false;
                    });
                  }
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

              // change visibility of reset password field
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState( () {
                        _resetPassField = !_resetPassField;
                      });
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),

              // reset password field
              SizedBox(height: 32),
              Visibility(
                visible: _resetPassField,
                child: Column(
                  children: [

                    Text("Send reset password link to:"),

                    Form(
                      key: _formKey2,
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          authForm(_emailTxtCtrl, "email"),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey2.currentState!.validate()) {
                          sendResetEmail(
                            context,
                            _emailTxtCtrl.text.trim()
                          );
                        }
                      },
                      child: Text("send"),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
