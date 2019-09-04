import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/commons/commons.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/models.dart';
import 'package:scholar_agenda/widgets/timetable.dart';

import '../navigation.dart';
import 'period_form.dart';
import 'timetable_manage.dart';

class TimetablePage extends StatefulWidget {
  static const String routeName = "/timetable";

  TimetablePage({Key key}) : super(key: key);

  @override
  _TimetablePageState createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  DefaultTimetableBloc _defaultTimetableBloc;
  TimetablePeriodsBloc _timetablePeriodsBloc;
  SubjectsBloc _subjectsBloc;
  TimetablePageTabBloc _timetablePageTabBloc;

  _TimetablePageState();

  @override
  void initState() {
    super.initState();
    _timetablePageTabBloc = TimetablePageTabBloc();
    _defaultTimetableBloc = BlocProvider.of<DefaultTimetableBloc>(context);
    _timetablePeriodsBloc = BlocProvider.of<TimetablePeriodsBloc>(context);
    _subjectsBloc = BlocProvider.of<SubjectsBloc>(context);
    _defaultTimetableBloc..dispatch(LoadDefaultTimetable());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimetablePageTabBloc, TimetablePageTab>(
      bloc: _timetablePageTabBloc,
      builder: (context, tabState) {
        return BlocBuilder<DefaultTimetableBloc, DefaultTimetableState>(
            builder: (context, state) {
          final choices = _choices(tabState,
              state is DefaultTimetableLoaded ? state.timetable : null);
          final localization = Localization.of(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(localization.timetable),
              actions: <Widget>[
                IconButton(
                  icon: Icon(choices[0].icon),
                  onPressed: choices[0].onSelected,
                ),
                IconButton(
                  icon: Icon(choices[1].icon),
                  onPressed: choices[1].onSelected,
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
            body: _body(state, tabState),
            floatingActionButton: _fab(state),
          );
        });
      },
    );
  }

  List<Choice> _choices(TimetablePageTab state, Timetable timetable) {
    final localization = Localization.of(context);
    return <Choice>[
      Choice(
          title: localization.switchDisplay,
          icon: state == TimetablePageTab.weekView
              ? Icons.view_agenda
              : Icons.dashboard,
          onSelected: () {
            _timetablePageTabBloc.dispatch(ToggleTab());
          }),
      Choice(
          title: localization.refresh,
          icon: Icons.refresh,
          onSelected: () {
            if (timetable != null)
              _timetablePeriodsBloc.dispatch(LoadTimetablePeriods(timetable));
          }),
      Choice(
          title: localization.manageTimetable,
          icon: Icons.more_vert,
          onSelected: () {
            Navigator.of(context).pushNamed(TimetableManagePage.routeName);
          }),
    ];
  }

  Widget _body(DefaultTimetableState state, TimetablePageTab tabState) {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    if (state is DefaultTimetableLoaded) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<TimetablePeriodsBloc>(
            builder: (context) => _timetablePeriodsBloc,
          ),
          BlocProvider<SubjectsBloc>(
            builder: (context) => _subjectsBloc,
          )
        ],
        child: TimetableWidget(
          timetable: state.timetable,
          timetablePageTab: tabState,
        ),
      );
    } else if (state is DefaultTimetableNotSet) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.settings,
            size: 64,
            color: themeData.hintColor,
          ),
          Text(
            localization.defaultTimetableNotSet,
            style:
                themeData.textTheme.title.copyWith(color: themeData.hintColor),
          ),
        ],
      ));
    } else if (state is DefaultTimetableLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Text(localization.errorUnknownState);
    }
  }

  Widget _fab(DefaultTimetableState state) {
    return (state is DefaultTimetableLoaded)
        ? FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<TimetablePeriodsBloc>(
                      builder: (context) => _timetablePeriodsBloc,
                    ),
                    BlocProvider<SubjectsBloc>(
                      builder: (context) => _subjectsBloc,
                    )
                  ],
                  child: PeriodFormPage(
                    timetable: state.timetable,
                  ),
                ),
              ));
            },
          )
        : null;
    // timetable not defined
  }
}
