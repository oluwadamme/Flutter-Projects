import 'package:dada_money/auth/login.dart';
import 'package:dada_money/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // this will return home or auth screen
    final user = Provider.of<User>(context);
    if (user != null) {
      return const Home();
    } else {
      return const Login();
    }
  }
}
