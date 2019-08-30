import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/localization/localization.dart';
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

  _TimetablePageState();

  @override
  void initState() {
    super.initState();
    _defaultTimetableBloc = BlocProvider.of<DefaultTimetableBloc>(context);
    _timetablePeriodsBloc = BlocProvider.of<TimetablePeriodsBloc>(context);
    _subjectsBloc = BlocProvider.of<SubjectsBloc>(context);
    _defaultTimetableBloc..dispatch(LoadDefaultTimetable());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = Localization.of(context);
    final choices = _buildChoices(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).timetable),
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
      body: BlocBuilder<DefaultTimetableBloc, DefaultTimetableState>(
        builder: (context, state) {
          if (state is DefaultTimetableLoaded) {
            return BlocProvider.value(
              value: _timetablePeriodsBloc,
              child: TimetableWidget(
                timetable: state.timetable,
              ),
            );
          } else if (state is DefaultTimetableNotSet) {
            return Center(
                child: Text(
              localization.defaultTimetableNotSet,
              style: theme.textTheme.title,
            ));
          } else if (state is DefaultTimetableLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Text(localization.errorUnknownState);
          }
        },
      ),
      floatingActionButton:
          BlocBuilder<DefaultTimetableBloc, DefaultTimetableState>(
              builder: _buildSpeedDial),
    );
  }

  SpeedDial _buildSpeedDial(BuildContext context, DefaultTimetableState state) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      overlayColor: Colors.black,
      overlayOpacity: .5,
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      foregroundColor: Colors.white,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(Icons.brush),
          backgroundColor: Colors.blue,
          label: 'Second',
          labelBackgroundColor: Colors.black54,
          labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
          onTap: () {},
        ),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice),
          backgroundColor: Colors.green,
          label: 'Third',
          labelBackgroundColor: Colors.black54,
          labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
          onTap: () {},
        ),
        SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
            label: 'Add',
            labelBackgroundColor: Colors.black54,
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
            onTap: () {
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
                    timetable: (state as DefaultTimetableLoaded).timetable,
                  ),
                ),
              ));
            }),
      ],
    );
  }

  List<Choice> _buildChoices(BuildContext context) {
    return <Choice>[
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
}

class Choice {
  const Choice({this.title, this.icon, this.onSelected});

  final String title;
  final IconData icon;
  final VoidCallback onSelected;
}
