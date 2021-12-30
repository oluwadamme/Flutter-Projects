import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:portfolio/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class EmailSender extends StatefulWidget {
  const EmailSender({Key? key}) : super(key: key);

  @override
  _EmailSenderState createState() => _EmailSenderState();
}

class _EmailSenderState extends State<EmailSender> {
  List<String> attachments = [];

  final _subjectController = TextEditingController(text: '');

  final _bodyController = TextEditingController(
    text: '',
  );
  Future<void> launchMailto() async {
    final mailtoLink = Mailto(
      to: ['adeniyidamilola246@gmail.com'],
      subject: _subjectController.text,
      body: _bodyController.text,
    );
    // Convert the Mailto instance into a string.
    // Use either Dart's string interpolation
    // or the toString() method.
    await launch('$mailtoLink');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Me'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _subjectController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Subject',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: _bodyController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                      labelText: 'Body', border: OutlineInputBorder()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  await launchMailto();
                },
                child: const Center(
                  child: Text(
                    "Send",
                    style: TextStyle(color: darkColor),
                  ),
                ),
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 2,
                        vertical: defaultPadding),
                    backgroundColor: primaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
