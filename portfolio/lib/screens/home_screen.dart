import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/models/responsive.dart';
import 'package:portfolio/screens/email.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? null
          : AppBar(
              backgroundColor: bgColor,
              leading: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu)),
              )),
      drawer: SideMenu(),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: maxWidth),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (Responsive.isDesktop(context))
                Expanded(flex: 1, child: SideMenu()),
              SizedBox(
                width: defaultPadding,
              ),
              Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [...children],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

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

class Knowledges extends StatelessWidget {
  const Knowledges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Text(
            "Knowledge",
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        KnowlegeText(text: "Flutter, Dart"),
        KnowlegeText(text: "Git"),
        KnowlegeText(text: "RESTful APIs"),
        KnowlegeText(text: "Graphql"),
        KnowlegeText(text: "Stacked Architecture"),
      ],
    );
  }
}

class KnowlegeText extends StatelessWidget {
  const KnowlegeText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset("assets/icons/check.svg"),
        SizedBox(
          width: defaultPadding / 2,
        ),
        Text(text),
      ],
    );
  }
}

class Coding extends StatelessWidget {
  const Coding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Text(
            'Coding',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        AniminatedLinearProgressIndicator(
          label: "Dart",
          percentage: 0.7,
        ),
        SizedBox(width: defaultPadding),
        AniminatedLinearProgressIndicator(
          label: "Python",
          percentage: 0.8,
        ),
        SizedBox(width: defaultPadding),
        AniminatedLinearProgressIndicator(
          label: "JavaScript",
          percentage: 0.7,
        ),
      ],
    );
  }
}

class AniminatedLinearProgressIndicator extends StatelessWidget {
  const AniminatedLinearProgressIndicator({
    Key? key,
    required this.label,
    required this.percentage,
  }) : super(key: key);
  final String label;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: percentage),
          duration: defaultDuration,
          builder: (context, double value, child) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        (value * 100).toInt().toString() + '%',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  SizedBox(height: defaultPadding / 2),
                  LinearProgressIndicator(
                    backgroundColor: darkColor,
                    value: value,
                    color: primaryColor,
                  ),
                ],
              )),
    );
  }
}

class Skills extends StatelessWidget {
  const Skills({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Text(
            'Skills',
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        Row(
          children: const [
            Expanded(
              child: AniminatedCircularProgressIndicator(
                label: "Flutter",
                percentage: 0.8,
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: AniminatedCircularProgressIndicator(
                label: "Firebase",
                percentage: 0.7,
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: AniminatedCircularProgressIndicator(
                label: "NodeJs",
                percentage: 0.5,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class AniminatedCircularProgressIndicator extends StatelessWidget {
  final double percentage;
  final String label;
  const AniminatedCircularProgressIndicator({
    Key? key,
    required this.percentage,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: percentage),
              duration: defaultDuration,
              builder: (context, double value, child) => Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        backgroundColor: darkColor,
                        value: value,
                        color: primaryColor,
                      ),
                      Center(
                          child: Text(
                        (value * 100).toInt().toString() + '%',
                        style: Theme.of(context).textTheme.subtitle1,
                      ))
                    ],
                  )),
        ),
        const SizedBox(
          height: defaultPadding / 2,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle2,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}

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
