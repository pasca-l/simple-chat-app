import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future passwordSignUp(String email, String password) async {
    try {
      final UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = cred.user;
      return user;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future passwordSignIn(String email, String password) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      User? user = cred.user;
      return user;
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
