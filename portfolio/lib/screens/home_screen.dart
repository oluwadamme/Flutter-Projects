import 'package:flutter/material.dart';
import 'package:portfolio/screens/side_menu/side_menu.dart';
import 'package:portfolio/utils/constant.dart';
import 'package:portfolio/models/responsive.dart';

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
