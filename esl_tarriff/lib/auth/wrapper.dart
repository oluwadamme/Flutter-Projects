
import 'package:esl_tarriff/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

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
