import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_social/models/user.dart';
import 'package:my_social/services/database.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  User _user;

  User _userFromFirebase(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, email: user.email, name: user.displayName)
        : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user)=> _userFromFirebaseUser(user)) this is the same
        .map(_userFromFirebase);
  }

  User getCurrentUser(){
    return _user;
  }

  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      _user = _userFromFirebase(user);
      return _user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future register(
      String email, String password, String name, String phoneNumber) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      DatabaseService(uid: user.uid).createUser(name, email, phoneNumber);
      _user = _userFromFirebase(user);
      return _user;
    } catch (e) {
      print("Error here");
      print(e.toString());
      return null;
    }
  }
}
