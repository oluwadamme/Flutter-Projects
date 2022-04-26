import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/utils/constant.dart';

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
