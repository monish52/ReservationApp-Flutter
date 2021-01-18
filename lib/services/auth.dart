import 'package:flutter/material.dart';
import 'package:reservation/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reservation/services/database.dart';
import 'package:intl/intl.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object based on firebase user
  UserId _UserFromFirebaseUser(User user) {
    return user != null ? UserId(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserId> get user {
    return _auth
        .authStateChanges()
        //.map((User user) => _UserFromFirebaseUser(user));
        .map(_UserFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _UserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(
          'monish',
          81089,
          'monish@gmail.com',
          DateTime.now(),
          DateFormat.Hms().format(DateTime.now()).toString());
      return _UserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in using email and password
  Future signInWithEmailAndPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _UserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
