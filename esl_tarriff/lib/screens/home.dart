
import 'package:esl_tarriff/models/user.dart';
import 'package:esl_tarriff/screens/pay.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';
import 'loading.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with ChangeNotifier {
  UserModel userModel;

  Future<UserModel> getData() async {
    final DatabaseReference fb = FirebaseDatabase.instance.reference();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('email');
    final child = fb.child(user).once().then((value) {
      final data = Map<String, dynamic>.from(value.value);
      userModel = UserModel.fromData(data);
      notifyListeners();
      return userModel;
    });

    return child;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel userModel = snapshot.data;
            //print('userModel: $userModel');
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                title: const Center(
                  child: Text(
                    'Consumption Details',
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              backgroundColor: const Color(0xFFBDBDBD),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Pay()));
                },
                child: const Text(
                  'PAY',
                  style: kButtonTextStyle,
                ),
                backgroundColor: kPrimaryColor,
                elevation: 2,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const VerticalSpacing(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Wrap(
                      runSpacing: 20,
                      spacing: 20,

                      alignment: WrapAlignment.center,
                      //direction: Axis.vertical,
                      children: [
                        ConsumptionCard(
                            name: 'Energy Bought',
                            value: userModel.bought_energy,
                            symbol: 'kWh'),
                        ConsumptionCard(
                            name: 'Energy Available',
                            value: userModel.energy_available,
                            symbol: 'kWh'),
                        ConsumptionCard(
                            name: 'Voltage',
                            value: userModel.voltage_input,
                            symbol: 'V'),
                        ConsumptionCard(
                            name: 'Current',
                            value: userModel.current,
                            symbol: 'amp'),
                        ConsumptionCard(
                            name: 'Power',
                            value: userModel.power,
                            symbol: 'kW'),
                        ConsumptionCard(
                            name: 'Energy Consumed',
                            value: userModel.energy_consumed,
                            symbol: 'kWh'),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const LoadingWidget();
          }
        });
  }
}

class ConsumptionCard extends StatelessWidget {
  final String name, value, symbol;

  const ConsumptionCard({Key key, this.name, this.value, this.symbol})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
          height: size.width * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: kPrimaryColor, width: 2)),
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: kIconColor),
              ),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              Text(
                symbol,
                style: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              )
            ],
          )),
    );
  }
}
