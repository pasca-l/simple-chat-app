import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/modules/user.dart';

class AuthMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userIdFromFirebase(User user) {
    return user != null ? User(userId: user.uid) : null;
  }

  Future signInWithEmail(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword
        (email: email, password: password);
      // User firebaseUser = result.user; //省略可？
      return _userIdFromFirebase(result.user);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future signUpWithEmail(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword
        (email: email, password: password);
      User firebaseUser = result.user;
      return _userIdFromFirebase(firebaseUser);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
    }
  }
}
