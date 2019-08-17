import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/localization.dart';
import 'page/agenda/agenda_page.dart';
import 'page/calendar/calendar.dart';
import 'page/help_and_feedback/help_and_feedback.dart';
import 'page/home/home_page.dart';
import 'page/settings/settings_page.dart';
import 'page/subject/subject_page.dart';
import 'page/timetable/timetable_manage.dart';
import 'page/timetable/timetable_page.dart';
import 'service/dao.dart';

void main() async {
  DbService();
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
        TimetableManagePage.routeName: (context) => TimetableManagePage(),
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
