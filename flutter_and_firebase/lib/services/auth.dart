import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_and_firebase/models/user.dart';
import 'package:flutter_and_firebase/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user obj based on Firebase User
  User _userFromFirebase (FirebaseUser firebaseUser) {
    return firebaseUser != null ? User(uid: firebaseUser.uid) : null;
  }

  //Create stream for auth changes
  Stream <User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebase);
  }

  // sign in anonymously
  Future signInAnon () async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user).uid;

    } catch (e) {

      print (e.toString());
      return null;
    }
  }
  
  //sign in with email & password
  Future signInWithEmail (String email, String password) async {

    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);

    } catch (e) {
      print(e.toString());
      return null;
    }

  }

  //register in with email & password

  Future registerWithEmail (String email, String password) async {

    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //Create new document for the user with the uid from firebase
      await DatabaseService (uid: user.uid).updateUserData('0', 'new member', 100);
      return _userFromFirebase(user);

    } catch (e) {
      print(e.toString());
      return null;
    }

  }

  //sign out
    Future signOut () async {
    try {
      return  await _auth.signOut();
    } catch (e){
      print(e.toString());
      return null;
    }
   }
}