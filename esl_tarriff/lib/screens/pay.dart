
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class Pay extends StatefulWidget {
  const Pay({Key key}) : super(key: key);

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  String email;
  String fullName;
  TextEditingController _amount;
  TextEditingController _meterId;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  final double tariff = 5;
  final double vat = 0.075;
  double amount;
  double unit;
  static String publicKey = dotenv.env['PUBLIC_KEY'].toString();
  final plugin = PaystackPlugin();

  @override
  void initState() {
    plugin.initialize(publicKey: publicKey);
    _amount = TextEditingController();
    _meterId = TextEditingController();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _amount.dispose();
    _meterId.dispose();
    super.dispose();
  }

  void _showSnackBar(String value) {
    if (value.isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(value),
        ),
      );
    }
  }

  Future<CheckoutResponse> makePayment() async {
    Charge charge = Charge()
      ..amount = amount.toInt() * 100
      ..reference = DateTime.now().millisecondsSinceEpoch.toString()
      // or ..accessCode = _getAccessCodeFrmInitialization()
      ..email = email;
    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card, // Defaults to CheckoutMethod.selectable
      charge: charge,
    );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFBDBDBD),
      appBar: AppBar(
        title: const Text(
          'Make Payment',
          style: kHeaderTextStyle,
        ),
        backgroundColor: kPrimaryColor,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Full Name',
                  style: TextStyle(color: kPrimaryColor),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Cannot be empty",
                    onChanged: (value) => setState(() => fullName = value),
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      hintText: 'Full Name',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Text(
                  'Email Address',
                  style: TextStyle(color: kPrimaryColor),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    //controller: _email,

                    validator: (value) =>
                        value.isNotEmpty ? null : "Cannot be empty",
                    onChanged: (value) => setState(() => email = value),
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      hintText: 'Email Address',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Text(
                  'Meter Number',
                  style: TextStyle(color: kPrimaryColor),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextFormField(
                    controller: _meterId,
                    //keyboardType: TextInputType.number,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Cannot be empty",
                    //onChanged: (value) => setState(() => _meterId.text = value),
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      hintText: 'Meter Number',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Text(
                  'Amount',
                  style: TextStyle(color: kPrimaryColor),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: TextFormField(
                    controller: _amount,

                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value.isNotEmpty ? null : "Cannot be empty",
                    //onChanged: (value) => setState(() => amount = value),
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                      hintText: 'Enter Amount',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const VerticalSpacing(),
                RoundedButton(
                  text: "PAY",
                  press: () async {
                    if (_formkey.currentState.validate()) {
                      final DatabaseReference fb =
                          FirebaseDatabase.instance.reference();
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      String user = preferences.get('email');
                      var child = fb.child(user);
                      amount = double.parse(_amount.text);
                      if (amount >= 10) {
                        await makePayment().then((value) async {
                          if (value.message == 'Success') {
                            amount = amount - (vat * amount);
                            unit = amount / tariff;
                            await child
                                .update({'bought_energy': unit});
                            _showSnackBar('Payment Successful');
                            Navigator.pop(context);
                          } else {
                            _showSnackBar('Payment not Successful');
                          }
                        });
                      } else {
                        _showSnackBar('Amount not up to 10 naira');
                      }
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
    );
  }
}
