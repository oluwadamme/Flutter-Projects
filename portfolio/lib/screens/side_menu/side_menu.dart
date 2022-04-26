import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/component/info.dart';
import 'package:portfolio/screens/coding/coding.dart';
import 'package:portfolio/screens/email.dart';
import 'package:portfolio/screens/knowledge/knowledges.dart';
import 'package:portfolio/screens/skill/skills.dart';
import 'package:portfolio/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const MyInfo(),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  AreaInfo(
                    title: "Residence",
                    text: 'Nigeria',
                  ),
                  AreaInfo(
                    title: "City",
                    text: 'Lagos',
                  ),
                  Skills(),
                  SizedBox(height: defaultPadding),
                  Coding(),
                  Knowledges(),
                  Divider(),
                  TextButton(
                      onPressed: () async {
                        String _url =
                            'https://firebasestorage.googleapis.com/v0/b/portfolio-8cdd7.appspot.com/o/Damilola-Adeniyi.pdf?alt=media&token=545a0104-e2ff-424e-a244-dccae2442f98';
                        if (!await launch(_url)) throw 'Could not launch $_url';
                      },
                      child: FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "DOWNLOAD CV",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color),
                            ),
                            SizedBox(width: defaultPadding / 2),
                            SvgPicture.asset("assets/icons/download.svg")
                          ],
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: defaultPadding),
                    color: Color(0xFF24242E),
                    child: Row(
                      children: [
                        Spacer(),
                        IconButton(
                            onPressed: () async {
                              String _url =
                                  'https://www.linkedin.com/in/adeniyi-damilola-01/';
                              if (!await launch(_url))
                                throw 'Could not launch $_url';
                            },
                            icon:
                                SvgPicture.asset("assets/icons/linkedin.svg")),
                        IconButton(
                            onPressed: () async {
                              String _url = 'https://github.com/oluwadamme';
                              if (!await launch(_url))
                                throw 'Could not launch $_url';
                            },
                            icon: SvgPicture.asset("assets/icons/github.svg")),
                        IconButton(
                            onPressed: () async {
                              String _url = 'https://twitter.com/etz_dammie';
                              if (!await launch(_url))
                                throw 'Could not launch $_url';
                            },
                            icon: SvgPicture.asset("assets/icons/twitter.svg")),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EmailSender()));
                          },
                          icon: Icon(
                            Icons.email_rounded,
                            color: bodyTextColor,
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
