import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scholar_agenda/page/agenda/agenda_page.dart';
import 'package:scholar_agenda/page/calendar/calendar.dart';
import 'package:scholar_agenda/page/help_and_feedback/help_and_feedback.dart';
import 'package:scholar_agenda/page/home/home_page.dart';
import 'package:scholar_agenda/page/settings/settings_page.dart';
import 'package:scholar_agenda/page/subject/subject_page.dart';
import 'package:scholar_agenda/page/timetable/timetable_page.dart';
import 'package:scholar_agenda/service/dao.dart';

import 'localization/localization.dart';

void main() async {
  var dbService = DbService();
  await dbService.initialize();
  runApp(ScholarAgendaApp());
}

class ScholarAgendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scholar Agenda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigo,
        accentColor: Colors.blue,
        primaryColorDark: Colors.indigo[800],
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        AgendaPage.routeName: (context) => AgendaPage(),
        SubjectPage.routeName: (context) => SubjectPage(),
        TimetablePage.routeName: (context) => TimetablePage(),
        CalendarPage.routeName: (context) => CalendarPage(),
        HelpAndFeedbackPage.routeName: (context) => HelpAndFeedbackPage(),
        SettingsPage.routeName: (context) => SettingsPage(),
      },
      localizationsDelegates: [
        const ScholarAgendaAppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('fr'),
      ],
    );
  }
}
