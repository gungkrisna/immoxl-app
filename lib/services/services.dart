import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:IMMOXL/services/user_services.dart';
import 'package:flutter/services.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class Auth {
  static Future<String> emailLogin(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  static Future<String> emailRegister(
      String email, String password, String name) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password);
    FirebaseUser user = result.user;
    DatabaseService(uid: user.uid).updateUserData(name, email);
    return user.uid;
  }

  static Future<String> updateUserType(bool isAgent, String company) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseService(uid: user.uid).updateUserType(isAgent, company);
    return user.uid;
  }

  static Future<String> updateAvatar(String avatar) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseService(uid: user.uid).updateAvatar(avatar);
    return user.uid;
  }

  static Future<String> updateUserLocation(
      String address, String longitude, String latitude, String state) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseService(uid: user.uid)
        .updateUserLocation(address, longitude, latitude, state);
    return user.uid;
  }

  static Future<String> updateProfile(
      String name, String phonenumber, String website) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DatabaseService(uid: user.uid).updateProfile(name, phonenumber, website);
    return user.uid;
  }

  static Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }

  static Future<FirebaseUser> getCurrentFirebaseUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      return e.message;
    }
    return 'Error';
  }
}
