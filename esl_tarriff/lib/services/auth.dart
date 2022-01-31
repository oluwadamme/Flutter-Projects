import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create method to sign in with email/password
  Future login(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = authResult.user;
      return user;
    } on SocketException {
      return null;
      //print('No Internet Connection');
    } catch (e) {
      //print(e.toString());
      return null;
    }
  }

  // sign out
  Future logout() async {
    await _auth.signOut();
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.authStateChanges().map((User user) => user);
  }
}
