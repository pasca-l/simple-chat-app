import 'package:flutter/material.dart';
import 'package:chatapp/widgets/widget.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController emailTextController = new TextEditingController();
  TextEditingController passwordTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // email and password
                SizedBox(height: 8),
                TextField(
                  controller: emailTextController,
                  style: textInputFieldStyle(),
                  decoration: textInputFieldDeco("email"),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: passwordTextController,
                  style: textInputFieldStyle(),
                  decoration: textInputFieldDeco("password"),
                ),
                SizedBox(height: 8),

                // forgot password
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text("Forgot Password?",
                                style: textInputFieldStyle()
                    ),
                  ),
                ),

                // signin buttons
                SizedBox(height: 8),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width, //わからん
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF64B5F6),
                        Color(0xFFA1887F),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("Sign In"),
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width, //わからん
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text("Sign In with Google"),
                ),


                // Register
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account? ", style: TextStyle(color: Colors.white)),
                    Text("Register now", style: TextStyle(decoration: TextDecoration.underline)),
                  ],
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
