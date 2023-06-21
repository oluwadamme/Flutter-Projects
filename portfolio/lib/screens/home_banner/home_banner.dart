import 'package:flutter/material.dart';
import 'package:portfolio/component/build_animated.dart';
import 'package:portfolio/models/responsive.dart';
import 'package:portfolio/screens/email.dart';
import 'package:portfolio/utils/constant.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: Responsive.isMobile(context) ? 2.5 : 3,
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
                  'Discover my Awesome \nDesign and Development World!',
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.bold, color: Colors.white)
                      : Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                if (Responsive.isMobileLarge(context))
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                const MyBuildAnimatedText(),
                const SizedBox(
                  height: defaultPadding,
                ),
                if (!Responsive.isMobileLarge(context))
                  ElevatedButton(
                    onPressed: () {
                      // String _url = 'adeniyidamilola@gmail.com';
                      // if (!await launch(_url)) throw 'Could not launch $_url';
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EmailSender()));
                    },
                    child: const Text(
                      "Contact me",
                      style: TextStyle(color: darkColor),
                    ),
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2, vertical: defaultPadding),
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
