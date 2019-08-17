import 'package:flutter/material.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/page/navigation.dart';

import 'timetable_manage.dart';

class TimetablePage extends StatefulWidget {
  static const String routeName = "/timetable";

  final String title = "Timetable";

  TimetablePage({Key key}) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  _action() {}

  @override
  Widget build(BuildContext context) {
    var choices = buildChoices(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(choices[0].icon),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(choices[1].icon),
            onPressed: () {},
          ),
          PopupMenuButton<Choice>(
            onSelected: (choice) {
              choice.onSelected();
            },
            itemBuilder: (BuildContext context) {
              return choices.skip(2).map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: new NavigationDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Timetable',
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

  static List<Choice> buildChoices(BuildContext context) => <Choice>[
        Choice(
            title: Localization.of(context).switchDisplay,
            icon: Icons.view_agenda,
            onSelected: () {}),
        Choice(
            title: Localization.of(context).refresh,
            icon: Icons.refresh,
            onSelected: () {}),
        Choice(
            title: Localization.of(context).manageTimetable,
            icon: Icons.more_vert,
            onSelected: () {
              print('Taped');
              Navigator.of(context).pushNamed(TimetableManagePage.routeName);
            }),
      ];
}

class Choice {
  const Choice({this.title, this.icon, this.onSelected});

  final String title;
  final IconData icon;
  final VoidCallback onSelected;
}
