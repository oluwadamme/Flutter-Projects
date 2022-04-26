import 'package:flutter/material.dart';
import 'package:portfolio/utils/constant.dart';

class AreaInfo extends StatelessWidget {
  const AreaInfo({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);
  final String title, text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          Text(
            text,
          ),
        ],
      ),
    );
  }
}

class MyInfo extends StatelessWidget {
  const MyInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        color: secondaryColor,
        child: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/dammy.JPG'),
            ),
            Spacer(),
            Text(
              "Damilola Adeniyi",
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              'Flutter Developer & Software Developer',
              style: TextStyle(fontWeight: FontWeight.w200, height: 1.5),
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
