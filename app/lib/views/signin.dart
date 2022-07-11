import 'package:flutter/material.dart';
import 'package:app/modules/auth.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/form.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:app/views/signup.dart';
import 'package:app/views/user_home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Authentication authMthd = new Authentication();

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameTxtCtrl = new TextEditingController();
  TextEditingController emailTxtCtrl = new TextEditingController();
  TextEditingController passwordTxtCtrl = new TextEditingController();

  bool isLoading = false;

  SignIn() {
    if (_formKey.currentState!.validate()) {
      setState( () {
        isLoading = true;
      });

      authMthd.passwordSignIn(
        emailTxtCtrl.text,
        passwordTxtCtrl.text
      ).then( (result) {

        setState( () {
          isLoading = false;
        });

        if (result == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar('No user found for that email.')
          );
        } else if (result == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar('Wrong password provided for that user.')
          );
        } else if (result == null){
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar('Some problem occured, please try again.')
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserHome())
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(),
      body: isLoading ?
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
                    authForm(emailTxtCtrl, "email"),
                    SizedBox(height: 8),
                    authForm(passwordTxtCtrl, "password"),
                    SizedBox(height: 8),
                  ],
                ),
              ),

              // signin button
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  SignIn();
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

              SizedBox(height: 16),
              Row(
                children: [
                  Text("Don't have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp())
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal:16, vertical:8),
                      child: Text("Sign up"),
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
