import 'package:flutter/material.dart';
import 'package:portfolio/utils/constant.dart';

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
