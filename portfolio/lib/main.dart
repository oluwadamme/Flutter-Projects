import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/constant.dart';
import 'package:portfolio/models/Recommendation.dart';
import 'package:portfolio/models/projects.dart';
import 'package:portfolio/models/responsive.dart';
import 'package:portfolio/screens/email.dart';
import 'package:portfolio/screens/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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
        children: [
          HomeBanner(),
          Divider(),
          HighLightsInfo(),
          Divider(),
          MyProjects(),
          //Recommendations()
        ],
      ),
    );
  }
}

class Recommendations extends StatelessWidget {
  const Recommendations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reviews & Recommendations',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                demo_recommendations.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: defaultPadding),
                  child: RecommendationCard(
                    recommendation: demo_recommendations[index],
                  ),
                ),
              )),
            ),
          ],
        ));
  }
}

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    Key? key,
    required this.recommendation,
  }) : super(key: key);
  final Recommendation recommendation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      color: secondaryColor,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recommendation.name!,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            recommendation.source!,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Text(
            recommendation.text!,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class MyProjects extends StatelessWidget {
  const MyProjects({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Projects",
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: Colors.white),
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        const Responsive(
          mobile: ProjectGrid(
            crossAxisCount: 1,
            childAspectRatio: 1.7,
          ),
          desktop: ProjectGrid(),
          tablet: ProjectGrid(childAspectRatio: 1.1),
          mobileLarge: ProjectGrid(
            crossAxisCount: 2,
          ),
        )
      ],
    );
  }
}

class ProjectGrid extends StatelessWidget {
  const ProjectGrid({
    Key? key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.9,
  }) : super(key: key);
  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: demo_projects.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: defaultPadding,
            childAspectRatio: childAspectRatio,
            mainAxisSpacing: defaultPadding),
        itemBuilder: (context, index) => ProjectCard(
              project: demo_projects[index],
            ));
  }
}

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key,
    required this.project,
  }) : super(key: key);
  final Project project;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        String _url = project.url!;
        if (!await launch(_url)) throw 'Could not launch $_url';
      },
      style: TextButton.styleFrom(
        onSurface: secondaryColor,
        backgroundColor: secondaryColor,
        padding: const EdgeInsets.all(defaultPadding),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            project.title!,
            maxLines: 2,
            style: Theme.of(context).textTheme.subtitle2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          Text(
            project.description!,
            maxLines: Responsive.isMobileLarge(context) ? 3 : 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(height: 1.5),
          ),
        ],
      ),
    );
  }
}

class HighLightsInfo extends StatelessWidget {
  const HighLightsInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AnimatedCounter(value: 15, test: '+'),
        const SizedBox(
          width: defaultPadding / 2,
        ),
        Text(
          'GitHub Projects',
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.white),
        )
      ],
    );
  }
}

class AnimatedCounter extends StatelessWidget {
  const AnimatedCounter({
    Key? key,
    required this.value,
    this.test,
  }) : super(key: key);
  final int value;
  final String? test;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: IntTween(begin: 0, end: value),
        duration: defaultDuration,
        builder: (context, value, child) => Text(
              "$value$test",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: primaryColor),
            ));
  }
}

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
                  'Discover my Awesome \nArt Space!',
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)
                      : Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                ),
                if (Responsive.isMobileLarge(context))
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                const MyBulidAnimatedText(),
                const SizedBox(
                  height: defaultPadding,
                ),
                if (!Responsive.isMobileLarge(context))
                  ElevatedButton(
                    onPressed: () {
                      // String _url = 'adeniyidamilola@gmail.com';
                      // if (!await launch(_url)) throw 'Could not launch $_url';
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmailSender()));
                    },
                    child: const Text(
                      "Contact me",
                      style: TextStyle(color: darkColor),
                    ),
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
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
