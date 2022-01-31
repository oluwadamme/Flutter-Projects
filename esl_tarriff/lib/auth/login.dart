import 'package:dada_money/constant.dart';
import 'package:dada_money/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({
    Key key,
  }) : super(key: key);
  //const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email;
  TextEditingController _password;
  bool _obscureText = true;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final loginProvider = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Form(
        key: _formkey,
        child: Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: size.width * 0.75,
              height: size.height * 0.45,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: kBackground),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(),
                  const Center(
                    child: Text(
                      'Enter Your Login Details',
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor),
                    ),
                  ),
                  const VerticalSpacing(),
                  const Text(
                    'Meter Number',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextFormField(
                      controller: _email,
                      //initialValue: userModel.bio,
                      keyboardType: TextInputType.text,
                      validator: (value) =>
                          value.isNotEmpty ? null : "Cannot be empty",
                      //onChanged: (value) => setState(() => _email.text = value),
                      cursorColor: kPrimaryColor,

                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          hintText: 'Meter Number',
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email,
                            color: kPrimaryColor,
                          )),
                    ),
                  ),
                  const VerticalSpacing(),
                  const Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: kPrimaryColor),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextFormField(
                      obscureText: _obscureText,
                      controller: _password,
                      //initialValue: userModel.bio,
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) => value.length >= 6
                          ? null
                          : "Cannot be less than 6 letters",
                      // onChanged: (value) =>
                      //     setState(() => _password.text = value),
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10),
                          hintText: 'Password',
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.password,
                            color: kPrimaryColor,
                          ),
                          suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: const Icon(
                                Icons.lock,
                                color: kPrimaryColor,
                              ))),
                    ),
                  ),
                  RoundedButton(
                    text: "LOGIN",
                    press: () async {
                      if (_formkey.currentState.validate()) {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        pref.setString('email', _email.text);
                        String email = _email.text + '@gmail.com';
                        await loginProvider.login(email, _password.text);
                      }
                    },
                    color: kPrimaryColor,
                    textColor: kTextFieldFillColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
