import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.signInMode,
    required this.onTap,
  }) : super(key: key);

  final bool signInMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
          signInMode ? "Sign In" : "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
      ),
    );
  }
}

class ToOtherPage extends StatelessWidget {
  const ToOtherPage({
    Key? key,
    required this.signInMode,
    required this.onTap,
  }) : super(key: key);

  final bool signInMode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(signInMode ? "Don't have an account? " : "Already registered? "),
        GestureDetector(
          onTap: onTap,
          child: Text(
            signInMode ? "Sign up" : "Sign in",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}