import 'package:flutter/material.dart';
import 'package:scholar_agenda/model/subject.dart';

class SubjectDetailPage extends StatefulWidget {
  static const routeName = "/subject/detail";

  final Subject subject;

  SubjectDetailPage({Key key, @required this.subject})
      : assert(subject != null),
        super(key: key);

  @override
  _SubjectDetailPageState createState() => _SubjectDetailPageState();
}

class _SubjectDetailPageState extends State<SubjectDetailPage> {
  _action() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subject.title),
        backgroundColor: widget.subject.color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Subject Details',
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
