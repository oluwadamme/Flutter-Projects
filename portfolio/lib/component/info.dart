import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/screens/email.dart';
import 'package:portfolio/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

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
      aspectRatio: 1.1,
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
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              'Flutter Developer & Software Developer',
              style: TextStyle(fontWeight: FontWeight.w200, height: 1.5),
              textAlign: TextAlign.center,
            ),
            Spacer(
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () async {
                      String _url = 'https://www.linkedin.com/in/adeniyi-damilola-01/';
                      if (!await launch(_url)) throw 'Could not launch $_url';
                    },
                    icon: SvgPicture.asset("assets/icons/linkedin.svg")),
                IconButton(
                    onPressed: () async {
                      String _url = 'https://github.com/oluwadamme';
                      if (!await launch(_url)) throw 'Could not launch $_url';
                    },
                    icon: SvgPicture.asset("assets/icons/github.svg")),
                IconButton(
                    onPressed: () async {
                      String _url = 'https://twitter.com/etz_dammie';
                      if (!await launch(_url)) throw 'Could not launch $_url';
                    },
                    icon: SvgPicture.asset("assets/icons/twitter.svg")),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EmailSender()));
                  },
                  icon: Icon(
                    Icons.email_rounded,
                    color: bodyTextColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
