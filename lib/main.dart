import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:scholar_agenda/page/agenda/agenda_page.dart';
import 'package:scholar_agenda/page/calendar/calendar.dart';
import 'package:scholar_agenda/page/home/home_page.dart';
import 'package:scholar_agenda/page/settings/settings_page.dart';
import 'package:scholar_agenda/page/subject/subject_page.dart';
import 'package:scholar_agenda/page/timetable/timetable_page.dart';

import 'localization/localization.dart';

void main() {
  //initializeDateFormatting().then((_) => runApp(ScholarAgendaApp()));
  runApp(ScholarAgendaApp());
}

class ScholarAgendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scholar agenda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        AgendaPage.routeName: (BuildContext context) => AgendaPage(),
        SubjectPage.routeName: (BuildContext context) => SubjectPage(),
        TimetablePage.routeName: (BuildContext context) => TimetablePage(),
        CalendarPage.routeName: (BuildContext context) => CalendarPage(),
        SettingsPage.routeName: (BuildContext context) => SettingsPage(),
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
