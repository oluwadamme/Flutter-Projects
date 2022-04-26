import 'package:flutter/material.dart';
import 'package:portfolio/models/projects_model.dart';
import 'package:portfolio/models/responsive.dart';
import 'package:portfolio/utils/constant.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final ProjectModel project;

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
