import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authentication {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('User');
  String email;
  Authentication(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.idTokenChanges();

  void newmail({String email1}) {
    this.email = email1;
  }

  String tomail() {
    return email;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      newmail(email1: email);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp(
      {String email,
      String password,
      String name1,
      String name2,
      String phone1}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      addDataFirst(email: email, name1: name1, name2: name2, phone1: phone1);
      newmail(email1: email);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> resetpass({String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> addDataFirst(
      {String email, String name1, String name2, String phone1}) async {
    await users
        .doc(email)
        .set({
          'firstname': name1,
          'lastname': name2,
          'phone': phone1,
          'email': email,
        })
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> subdata({String email, String name1}) async {
    await users
        .doc(email)
        .collection('faverite')
        .doc(name1)
        .set({
          'name': name1,
          'email': email,
        })
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addtrip({String email, String name1, String time}) async {
    await users
        .doc(email)
        .collection('trip')
        .doc(name1)
        .set({
          'name': name1,
          'email': email,
          'time': time,
        })
        .then((value) => print("Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
