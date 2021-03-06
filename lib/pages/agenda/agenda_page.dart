import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/commons/commons.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/event.dart';
import 'package:scholar_agenda/pages/agenda/event_form.dart';

import '../navigation.dart';
import 'event_detail.dart';

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
        body: BlocBuilder<EventsBloc, EventsState>(builder: (context, state) {
          if (state is EventsLoaded) {
            final events = state.events;
            final homeWorks =
                events.where((e) => e.type == EventType.homework).toList();
            final exams =
                events.where((e) => e.type == EventType.homework).toList();
            final reminders =
                events.where((e) => e.type == EventType.homework).toList();
            return TabBarView(
              children: [
                _homeWorksTab(homeWorks),
                _examsTab(exams),
                _remindersTab(reminders),
              ],
            );
          } else if (state is EventsLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: Text(localization.errorUnableToLoadData));
        }),
        floatingActionButton: _speedDial(),
      ),
    );
  }

  Widget _homeWorksTab(List<Event> events) {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    if (events.isNotEmpty) {
      final eventsByDateList = _groupEventByDate(events);
      return ListView(
        children: eventsByDateList.map((eventsByDate) {
          final localization = Localization.of(context);
          final themeData = Theme.of(context);
          final local = Localizations.localeOf(context).languageCode;
          final dateFormat = DateFormat.yMd(local);
          final schedule = eventsByDate.date.difference(DateTime.now()).inDays;
          return Wrap(
            children: <Widget>[
              ListTile(
                title: Text(
                  dateFormat.format(eventsByDate.date),
                  style: themeData.textTheme.headline
                      .copyWith(color: themeData.primaryColor),
                ),
                trailing: Text(
                  schedule == 0
                      ? 'Today'
                      : '${schedule.abs()}'
                          ' ${schedule > 0 ? '${localization.daysBefore}' : '${localization.daysAgo}'}',
                ),
              ),
              Card(
                elevation: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: eventsByDate.events
                      .map((event) => EventView(
                            event: event,
                            onTap: _eventOnTap,
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        }).toList(),
      );
    }
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

  Widget _examsTab(List<Event> events) {
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

  Widget _remindersTab(List<Event> events) {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.notifications,
            size: 64,
            color: themeData.hintColor,
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
        builder: (context) => BlocProvider.value(
              value: _subjectsBloc,
              child: BlocProvider.value(
                value: _eventsBloc,
                child: EventFormPage(
                  eventType: type,
                ),
              ),
            )));
  }

  void _eventOnTap(Event event) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider.value(
              value: _eventsBloc,
              child: BlocProvider.value(
                value: _subjectsBloc,
                child: EventDetailPage(
                  event: event,
                ),
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

  List<EventsByDay> _groupEventByDate(List<Event> events) {
    final days = events.map((e) => e.date).toSet().toList();

    //remove double
    return List.generate(
        days.length,
        (index) => EventsByDay(
            date: days[index],
            events: events
                .where(
                  (e) => e.date == days[index],
                )
                .toList())).toList()
      ..sort((e1, e2) => e1.date.compareTo(e2.date));
  }
}

class EventView extends StatelessWidget {
  final Event event;
  final EventCallback onTap;
  final EventCallback onLeftTap;

  const EventView({Key key, @required this.event, this.onTap, this.onLeftTap})
      : assert(event != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    final local = Localizations.localeOf(context).languageCode;
    final dateFormat = DateFormat.yMd(local);
    return Card(
      child: ListTile(
        title: Text(event.title),
        subtitle: Column(
          children: <Widget>[
            SizedBox(
              height: 2.0,
            ),
            Row(
              children: <Widget>[
                Icon(Icons.schedule, size: 12),
                Text(' ${dateFormat.format(event.date)}'),
              ],
            ),
            SizedBox(
              height: 2.0,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: event.subject == null
                        ? themeData.hintColor
                        : event.subject.color,
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  event.subject == null
                      ? '  ${localization.none}'
                      : '  ${event.subject.title}',
                )
              ],
            )
          ],
        ),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          onTap(event);
        },
      ),
    );
  }
}

class EventsByDay {
  final DateTime date;
  final List<Event> events;

  EventsByDay({@required this.date, @required this.events});
}

typedef EventCallback(Event event);
