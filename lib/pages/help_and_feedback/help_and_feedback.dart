import 'package:flutter/material.dart';
import 'package:scholar_agenda/localization/localization.dart';

import '../navigation.dart';

class HelpAndFeedbackPage extends StatefulWidget {
  static const routeName = "/help_and_feedback";

  HelpAndFeedbackPage({Key key}) : super(key: key);

  @override
  _HelpAndFeedbackPageState createState() => _HelpAndFeedbackPageState();
}

class _HelpAndFeedbackPageState extends State<HelpAndFeedbackPage> {
  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.helpAndFeedBack),
      ),
      drawer: new NavigationDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              localization.helpAndFeedBack,
            ),
          ],
        ),
      ),
    );
  }
}
