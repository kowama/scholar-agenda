import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scholar_agenda/blocs/default_timetable/default_timetable.dart';

import 'blocs/blocs.dart';
import 'localization/localization.dart';
import 'models/database.dart';
import 'pages/pages.dart';

const appName = 'Scholar Agenda';

class ScholarAgendaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scholarAgendaAppDb = Provider.of<ScholarAgendaAppDb>(context);
    final settingBloc = SettingsBloc()..dispatch(LoadSettings());
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigo,
        accentColor: Colors.blue,
        primaryColorDark: Colors.indigo[800],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.blue,
        primaryColorDark: Colors.indigo[800],
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        AgendaPage.routeName: (context) => AgendaPage(),
        SubjectPage.routeName: (context) => BlocProvider<SubjectBloc>(
              builder: (context) =>
                  SubjectBloc(subjectDao: scholarAgendaAppDb.subjectDao),
              child: SubjectPage(),
            ),
        TimetablePage.routeName: (context) =>
            BlocProvider<DefaultTimetableBloc>(
              builder: (context) =>
                  DefaultTimetableBloc(settingsBloc: settingBloc),
              child: TimetablePage(),
            ),
        TimetableManagePage.routeName: (context) => BlocProvider<TimetableBloc>(
              builder: (context) => TimetableBloc(
                timetableDao: scholarAgendaAppDb.timetableDao,
              ),
              child: TimetableManagePage(),
            ),
        CalendarPage.routeName: (context) => CalendarPage(),
        HelpAndFeedbackPage.routeName: (context) => HelpAndFeedbackPage(),
        SettingsPage.routeName: (context) => BlocProvider<SettingsBloc>(
            builder: (context) => settingBloc, child: SettingsPage()),
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
