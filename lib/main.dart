import 'package:flutter/material.dart';

import 'package:scholar_agenda/page/agenda/agenda_page.dart';
import 'package:scholar_agenda/page/home/home_page.dart';
import 'package:scholar_agenda/page/settings/settings_page.dart';
import 'package:scholar_agenda/page/subject/subject_page.dart';
import 'package:scholar_agenda/page/timetable/timetable_page.dart';

void main() => runApp(ScholarAgendaApp());

class ScholarAgendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scholar agenda',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Colors.indigo, primaryColor: Colors.indigo),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        AGENDA_PAGE_ROUTE: (BuildContext context) => AgendaPage(),
        SUBJECT_PAGE_ROUTE: (BuildContext context) => SubjectPage(),
        TIMETABLE_PAGE_ROUTE: (BuildContext context) => TimetablePage(),
        SETTINGS_PAGE_ROUTE: (BuildContext context) => SettingsPage(),
      },
    );
  }
}
