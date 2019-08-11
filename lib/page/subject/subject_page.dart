import 'package:flutter/material.dart';
import '../navigation.dart';

const String SUBJECT_PAGE_ROUTE = "/subject";

class SubjectPage extends StatefulWidget {
  SubjectPage({Key key}) : super(key: key);
  final String title = "Subjects";

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
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
              'Subjects',
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
