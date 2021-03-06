import 'package:flutter/material.dart';
import 'package:app/modules/auth.dart';
import 'package:app/widgets/appbar.dart';
import 'package:app/widgets/form.dart';
import 'package:app/widgets/snackbar.dart';
import 'package:app/views/signin.dart';
import 'package:app/views/user_home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Authentication authMthd = new Authentication();

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameTxtCtrl = new TextEditingController();
  TextEditingController emailTxtCtrl = new TextEditingController();
  TextEditingController passwordTxtCtrl = new TextEditingController();

  bool isLoading = false;

  signUp() {
    if (_formKey.currentState!.validate()) {
      setState( () {
        isLoading = true;
      });

      authMthd.passwordSignUp(
        emailTxtCtrl.text,
        passwordTxtCtrl.text
      ).then( (result) {

        setState( () {
          isLoading = false;
        });

        if (result == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar('The password provided is too weak.')
          );
        } else if (result == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            errorSnackBar('The account already exists for that email.')
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

              // username, email and password
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    authForm(usernameTxtCtrl, "username"),
                    SizedBox(height: 8),
                    authForm(emailTxtCtrl, "email"),
                    SizedBox(height: 8),
                    authForm(passwordTxtCtrl, "password"),
                    SizedBox(height: 8),
                  ],
                ),
              ),

              // signup button
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  signUp();
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

              SizedBox(height: 16),
              Row(
                children: [
                  Text("Already registered?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignIn())
                      );
                    },
                    child: Container(
                      child: Text("Sign in"),
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
