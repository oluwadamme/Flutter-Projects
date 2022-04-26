import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/component/flutter_coded_text.dart';
import 'package:portfolio/models/responsive.dart';
import 'package:portfolio/utils/constant.dart';

class MyBuildAnimatedText extends StatelessWidget {
  const MyBuildAnimatedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      maxLines: 1,
      style:
          Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
      child: Row(
        children: [
          if (!Responsive.isMobileLarge(context)) const FlutterCodedText(),
          if (!Responsive.isMobileLarge(context))
            const SizedBox(
              width: defaultPadding / 2,
            ),
          const Text('I build '),
          Responsive.isMobile(context)
              ? Expanded(
                  child: AnimatedTextKit(animatedTexts: [
                    TyperAnimatedText("responsible web and mobile apps.",
                        speed: const Duration(milliseconds: 60)),
                    TyperAnimatedText("payment apps.",
                        speed: const Duration(milliseconds: 60)),
                    TyperAnimatedText(
                        " and contribute to open source projects.",
                        speed: const Duration(milliseconds: 60))
                  ]),
                )
              : AnimatedTextKit(animatedTexts: [
                  TyperAnimatedText("responsible web and mobile apps.",
                      speed: const Duration(milliseconds: 60)),
                  TyperAnimatedText("payment apps.",
                      speed: const Duration(milliseconds: 60)),
                  TyperAnimatedText(" and contribute to open source projects.",
                      speed: const Duration(milliseconds: 60))
                ]),
          if (!Responsive.isMobileLarge(context))
            const SizedBox(
              width: defaultPadding / 2,
            ),
          if (!Responsive.isMobileLarge(context)) const FlutterCodedText(),
        ],
      ),
    );
  }
}
