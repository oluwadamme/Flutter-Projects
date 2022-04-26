import 'package:flutter/material.dart';
import 'package:portfolio/utils/constant.dart';

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
                label: "RESTful API",
                percentage: 0.8,
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
