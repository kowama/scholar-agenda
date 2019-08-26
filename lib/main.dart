import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/blocs/subject/bloc.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/pages/agenda/agenda_page.dart';

import 'models/models.dart';
import 'pages/pages.dart';
import 'pages/subject/subject_page.dart';

void main() async {
  runApp(
    Provider<SubjectBloc>(
      builder: (context) {
        final db = ScholarAgendaAppDb();
        return SubjectBloc(subjectDao: db.subjectDao)
          ..dispatch(LoadSubjectsEvent());
      },
      child: ScholarAgendaApp(),
      dispose: (context, bloc) => bloc.dispose(),
    ),
  );
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
//        TimetablePage.routeName: (context) => TimetablePage(),
//        TimetableManagePage.routeName: (context) => TimetableManagePage(),
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
