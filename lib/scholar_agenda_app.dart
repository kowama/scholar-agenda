import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

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
    final defaultTimetableBloc = DefaultTimetableBloc(
      settingsBloc: settingBloc,
    );
    final subjectBloc = SubjectsBloc(
      subjectDao: scholarAgendaAppDb.subjectDao,
    );
    return MaterialApp(
      themeMode: ThemeMode.system,
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent,
        primaryColorDark: Colors.indigo[800],
      ),
      darkTheme: ThemeData(
        primaryColor: Colors.teal[800],
        brightness: Brightness.dark,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        AgendaPage.routeName: (context) => AgendaPage(),
        SubjectPage.routeName: (context) => BlocProvider<SubjectsBloc>(
              builder: (context) => subjectBloc,
              child: SubjectPage(),
            ),
        TimetablePage.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DefaultTimetableBloc>(
                  builder: (context) => defaultTimetableBloc,
                ),
                BlocProvider<SubjectsBloc>(
                  builder: (context) => subjectBloc,
                ),
                BlocProvider<TimetablePeriodsBloc>(
                  builder: (context) => TimetablePeriodsBloc(
                    periodDao: scholarAgendaAppDb.periodDao,
                  ),
                ),
              ],
              child: TimetablePage(),
            ),
        TimetableManagePage.routeName: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<DefaultTimetableBloc>(
                  builder: (context) => defaultTimetableBloc,
                ),
                BlocProvider<TimetableBloc>(
                  builder: (context) => TimetableBloc(
                    timetableDao: scholarAgendaAppDb.timetableDao,
                  )..dispatch(LoadTimetables()),
                ),
              ],
              child: TimetableManagePage(),
            ),
        CalendarPage.routeName: (context) => CalendarPage(),
        HelpAndFeedbackPage.routeName: (context) => HelpAndFeedbackPage(),
        SettingsPage.routeName: (context) => BlocProvider.value(
              value: settingBloc,
              child: SettingsPage(),
            ),
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
