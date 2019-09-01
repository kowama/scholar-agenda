import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scholar_agenda/localization/localization.dart';

import '../navigation.dart';

class AgendaPage extends StatefulWidget {
  static const routeName = "/agenda";
  final String title = "Agenda";

  AgendaPage({Key key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.school)),
              Tab(icon: Icon(Icons.assignment)),
              Tab(icon: Icon(Icons.notifications)),
            ],
          ),
          title: Text(localization.agenda),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            )
          ],
        ),
        drawer: NavigationDrawer(),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.school,
                    size: 64,
                    color: themeData.hintColor,
                  ),
                  Text(
                    localization.noHomework,
                    style: themeData.textTheme.headline
                        .copyWith(color: themeData.hintColor),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.assignment,
                    size: 64,
                    color: themeData.hintColor,
                  ),
                  Text(
                    localization.noExams,
                    style: themeData.textTheme.headline
                        .copyWith(color: themeData.hintColor),
                  )
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.notifications,
                      size: 64, color: themeData.hintColor),
                  Text(
                    localization.noReminders,
                    style: themeData.textTheme.headline
                        .copyWith(color: themeData.hintColor),
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: _speedDial(),
      ),
    );
  }

  Widget _speedDial() {
    final themeData = Theme.of(context);
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      overlayColor: Colors.black,
      overlayOpacity: .5,
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            child: Icon(Icons.accessibility, color: themeData.cardColor),
            backgroundColor: Colors.red,
            label: 'First',
            labelBackgroundColor: themeData.hintColor,
            labelStyle: TextStyle(fontSize: 18.0, color: themeData.cardColor),
            onTap: () => print('FIRST CHILD')),
        SpeedDialChild(
          child: Icon(
            Icons.brush,
            color: themeData.cardColor,
          ),
          backgroundColor: Colors.blue,
          label: 'Second',
          labelBackgroundColor: themeData.hintColor,
          labelStyle: TextStyle(fontSize: 18.0, color: themeData.cardColor),
          onTap: () => print('SECOND CHILD'),
        ),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice, color: themeData.cardColor),
          backgroundColor: Colors.green,
          label: 'Third',
          labelBackgroundColor: themeData.hintColor,
          labelStyle: TextStyle(fontSize: 18.0, color: themeData.cardColor),
          onTap: () => print('THIRD CHILD'),
        ),
      ],
    );
  }
}
