import 'package:flutter/material.dart';
import '../navigation.dart';

class HelpAndFeedbackPage extends StatefulWidget {
  static const routeName = "/help_and_feedback";
  final String title = "Help and Feedback";

  HelpAndFeedbackPage({Key key}) : super(key: key);

  @override
  _HelpAndFeedbackPageState createState() => _HelpAndFeedbackPageState();
}

class _HelpAndFeedbackPageState extends State<HelpAndFeedbackPage> {
  _action() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: new NavigationDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _action(),
        tooltip: 'Action',
        child: Icon(Icons.add),
      ),
    );
  }
}
