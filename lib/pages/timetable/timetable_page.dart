import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/models.dart';

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
  final Future<Timetable> defaultTimetable;

  _TimetablePageState({this.defaultTimetable});

  @override
  Widget build(BuildContext context) {
    var choices = _buildChoices(context);
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
        body: Container(),
//        body: FutureBuilder<List<Period>>(
//          future: _timeTablesPeriod(),
//          builder: (context, snapshot) {
//            if (snapshot.hasData) {
//              return TimetableWidget(periods: snapshot.data);
//            } else if (snapshot.hasError) {
//              return Text("${snapshot.error}");
//            }
//
//            // By default, show a loading spinner.
//            return CircularProgressIndicator();
//          },
//        ),
        floatingActionButton: _buildSpeedDial(context));
  }

  SpeedDial _buildSpeedDial(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      overlayColor: Colors.black,
      overlayOpacity: .5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
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
          onTap: () => print('SECOND CHILD'),
        ),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice),
          backgroundColor: Colors.green,
          label: 'Third',
          labelBackgroundColor: Colors.black54,
          labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
          onTap: () async {
//            var t = await dbService.period.getAll();
//            print(t);
          },
        ),
        SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
            label: 'Add',
            labelBackgroundColor: Colors.black54,
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
            onTap: () async {
              var timetable = await defaultTimetable;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PeriodFormPage(
                        timetable: timetable,
                      )));
            }),
      ],
    );
  }

  static List<Choice> _buildChoices(BuildContext context) {
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
