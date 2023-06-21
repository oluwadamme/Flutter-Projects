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
                            'https://firebasestorage.googleapis.com/v0/b/portfolio-8cdd7.appspot.com/o/Damilola%20Adeniyi%20CV.pdf?alt=media&token=2d264ac1-dd7c-45ba-b485-0e0c33a1b33e';
                        if (!await launch(_url)) throw 'Could not launch $_url';
                      },
                      child: FittedBox(
                        child: Row(
                          children: [
                            Text(
                              "DOWNLOAD CV",
                              style: TextStyle(color: Theme.of(context).textTheme.bodyText1!.color),
                            ),
                            // SizedBox(width: defaultPadding / 2),
                            // SvgPicture.asset("assets/icons/download.svg")
                          ],
                        ),
                      )),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
