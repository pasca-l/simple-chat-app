import 'package:flutter/material.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
    required this.signInFormKey,
    required this.emailTxtCtrl,
    required this.passwordTxtCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> signInFormKey;
  final TextEditingController emailTxtCtrl;
  final TextEditingController passwordTxtCtrl;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signInFormKey,
      child: Column(
        children: [
          SizedBox(height: 8),
          _authFormField(emailTxtCtrl, "email"),
          SizedBox(height: 8),
          _authFormField(passwordTxtCtrl, "password"),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
    required this.signUpFormKey,
    required this.usernameTxtCtrl,
    required this.emailTxtCtrl,
    required this.passwordTxtCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> signUpFormKey;
  final TextEditingController usernameTxtCtrl;
  final TextEditingController emailTxtCtrl;
  final TextEditingController passwordTxtCtrl;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpFormKey,
      child: Column(
        children: [
          SizedBox(height: 8),
          _authFormField(usernameTxtCtrl, "username"),
          SizedBox(height: 8),
          _authFormField(emailTxtCtrl, "email"),
          SizedBox(height: 8),
          _authFormField(passwordTxtCtrl, "password"),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    Key? key,
    required this.resetPassFormKey,
    required this.emailTxtCtrl,
  }) : super(key: key);

  final GlobalKey<FormState> resetPassFormKey;
  final TextEditingController emailTxtCtrl;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: resetPassFormKey,
      child: Column(
        children: [
          SizedBox(height: 8),
          _authFormField(emailTxtCtrl, "email"),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

TextFormField _authFormField(TextEditingController txtCtrl, String hintText) {
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