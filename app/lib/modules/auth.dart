import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/widgets/widget_list.dart';

Future signIn(BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      errorSnackbar(context, "No user found for that email.");
    } else if (e.code == 'user-disabled') {
      errorSnackbar(context, "User disabled for that email.");
    } else if (e.code == 'wrong-password') {
      errorSnackbar(context, "Wrong password provided for that user.");
    } else {
      errorSnackbar(context, "Some problem occured with error ${e.code}.");
    }
  }
}

Future signUp(BuildContext context, String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      errorSnackbar(context, "The password provided is too weak.");
    } else if (e.code == 'email-already-in-use') {
      errorSnackbar(context, "The account already exists for that email.");
    } else {
      errorSnackbar(context, "Some problem occured with error ${e.code}.");
    }
  }
}

Future sendResetEmail(BuildContext context, String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email
    ).then( (value) {
      emailSentDialog(context);
    });
  } on FirebaseAuthException catch (e) {
    errorSnackbar(context, "Some problem occured, please try again.\nError code: [${e.code}]");
  }
}