import 'package:flutter/material.dart';
import 'package:chatapp/widgets/widget.dart';
import 'package:chatapp/modules/auth.dart';

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
    if (_formKey.currentState!.validate()){
      setState((){
        isLoading = true;
      });

      authMthd.passwordSignUp(
        emailTxtCtrl.text,
        passwordTxtCtrl.text
      ).then((result){
        print("$result");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ?
            Container(child: Center(child: CircularProgressIndicator())) :
            SingleChildScrollView(
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                // username, email and password
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      TextFormField(
                        validator: (val){
                          return "asdf";
                        },
                        controller: usernameTxtCtrl,
                        style: textInputFieldStyle(),
                        decoration: textInputFieldDeco("username"),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        validator: (val){
                          return "flajsdf";
                        },
                        controller: emailTxtCtrl,
                        style: textInputFieldStyle(),
                        decoration: textInputFieldDeco("email"),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return "faljfe";
                        },
                        controller: passwordTxtCtrl,
                        style: textInputFieldStyle(),
                        decoration: textInputFieldDeco("password"),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),

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
