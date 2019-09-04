import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/commons/commons.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/event.dart';
import 'package:scholar_agenda/pages/agenda/event_form.dart';

import '../navigation.dart';

class AgendaPage extends StatefulWidget {
  static const routeName = "/agenda";
  final String title = "Agenda";

  AgendaPage({Key key}) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  EventsBloc _eventsBloc;
  SubjectsBloc _subjectsBloc;

  @override
  void initState() {
    super.initState();
    _subjectsBloc = BlocProvider.of<SubjectsBloc>(context);
    _eventsBloc = BlocProvider.of<EventsBloc>(context);
    _eventsBloc.dispatch(LoadEvents());
  }

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    final choices = _choices();
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
            PopupMenuButton<Choice>(
              icon: Icon(Icons.filter_list),
              onSelected: (choice) {
                choice.onSelected();
              },
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.check_box_outline_blank),
                        Text(choice.title),
                      ],
                    ),
                  );
                }).toList();
              },
            ),
          ],
        ),
        drawer: NavigationDrawer(),
        body: TabBarView(
          children: [
            _homeWorksTab(),
            _examsTab(),
            _remindersTab(),
          ],
        ),
        floatingActionButton: _speedDial(),
      ),
    );
  }

  Widget _homeWorksTab() {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    return Center(
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
    );
  }

  Widget _examsTab() {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    return Center(
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
    );
  }

  Widget _remindersTab() {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.notifications,
              size: 64,
              color: themeData.hintColor,
            ),
            onTap: () {},
          ),
          Text(
            localization.noReminders,
            style: themeData.textTheme.headline
                .copyWith(color: themeData.hintColor),
          )
        ],
      ),
    );
  }

  Widget _speedDial() {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      animatedIconTheme: IconThemeData(size: 22.0),
      overlayColor: Colors.black,
      overlayOpacity: .5,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          child: Icon(Icons.notifications, color: themeData.cardColor),
          backgroundColor: Colors.pink,
          label: localization.reminder,
          labelBackgroundColor: themeData.hintColor,
          labelStyle: TextStyle(fontSize: 18.0, color: themeData.cardColor),
          onTap: () => _navigateToForm(EventType.reminder),
        ),
        SpeedDialChild(
          child: Icon(Icons.assignment, color: themeData.cardColor),
          backgroundColor: Colors.purple,
          label: localization.exam,
          labelBackgroundColor: themeData.hintColor,
          labelStyle: TextStyle(fontSize: 18.0, color: themeData.cardColor),
          onTap: () => _navigateToForm(EventType.exam),
        ),
        SpeedDialChild(
          child: Icon(Icons.school, color: themeData.cardColor),
          backgroundColor: Colors.teal,
          label: localization.homework,
          labelBackgroundColor: themeData.hintColor,
          labelStyle: TextStyle(fontSize: 18.0, color: themeData.cardColor),
          onTap: () => _navigateToForm(EventType.homework),
        ),
      ],
    );
  }

  void _navigateToForm(EventType type) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<SubjectsBloc>(
                  builder: (context) => _subjectsBloc,
                ),
                BlocProvider<EventsBloc>(
                  builder: (context) => _eventsBloc,
                )
              ],
              child: EventFormPage(
                eventType: type,
              ),
            )));
  }

  List<Choice> _choices() {
    return [
      Choice(title: 'All'),
      Choice(title: 'Uncompleted'),
      Choice(title: 'Completed'),
      Choice(title: 'Show passed')
    ];
  }
}
