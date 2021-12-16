import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: ThemeData.dark().copyWith(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: bgColor,
          canvasColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white)
              .copyWith(
                  bodyText1: const TextStyle(color: bodyTextColor),
                  bodyText2: const TextStyle(color: bodyTextColor))),
      home: const HomeScreen(
        children: [HomeBanner()],
      ),
    );
  }
}

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/bg.jpeg",
            fit: BoxFit.cover,
          ),
          Container(
            color: darkColor.withOpacity(0.66),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Discover my Awesome Art Space!',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                MyBulidAnimatedText(),
                SizedBox(
                  height: defaultPadding,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Explore Now",
                    style: TextStyle(color: darkColor),
                  ),
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: defaultPadding * 2,
                          vertical: defaultPadding),
                      backgroundColor: primaryColor),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyBulidAnimatedText extends StatelessWidget {
  const MyBulidAnimatedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style:
          Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
      child: Row(
        children: [
          FlutterCodedText(),
          SizedBox(
            width: defaultPadding / 2,
          ),
          Text('I build '),
          AnimatedTextKit(animatedTexts: [
            TyperAnimatedText("responsible web and mobile apps."),
            TyperAnimatedText("payment apps."),
            TyperAnimatedText(" and contribute to open source projects.")
          ]),
          SizedBox(
            width: defaultPadding / 2,
          ),
          FlutterCodedText(),
        ],
      ),
    );
  }
}

class FlutterCodedText extends StatelessWidget {
  const FlutterCodedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
      text: '<',
      children: [
        TextSpan(text: "flutter", style: TextStyle(color: primaryColor)),
        TextSpan(text: '/> '),
      ],
    ));
  }
}
