import 'package:flutter/material.dart';
import 'package:portfolio/utils/constant.dart';

class FlutterCodedText extends StatelessWidget {
  const FlutterCodedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text.rich(TextSpan(
      text: '<',
      children: [
        TextSpan(text: "flutter", style: TextStyle(color: primaryColor)),
        TextSpan(text: '> '),
      ],
    ));
  }
}
