import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/commons/choice.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/event.dart';
import 'package:share/share.dart';

import 'event_form.dart';

class EventDetailPage extends StatefulWidget {
  static const routeName = 'agenda/event/detail';
  final Event event;

  const EventDetailPage({Key key, @required this.event}) : super(key: key);

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  EventsBloc _eventsBloc;
  SubjectsBloc _subjectsBloc;

  Event get event => widget.event;

  @override
  void initState() {
    super.initState();
    _subjectsBloc = BlocProvider.of<SubjectsBloc>(context);
    _eventsBloc = BlocProvider.of<EventsBloc>(context);
    _eventsBloc.dispatch(LoadEvents());
  }

  @override
  Widget build(BuildContext context) {
    final actions = _choices();
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: actions
            .map((action) => IconButton(
                  icon: Icon(action.icon),
                  onPressed: () {
                    action.onSelected();
                  },
                ))
            .toList(),
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.title,
                  color: themeData.cardColor,
                ),
                Text('  ${event.title}',
                    style: themeData.textTheme.title
                        .copyWith(color: themeData.cardColor)),
              ],
            ),
          ),
          preferredSize: const Size.fromHeight(96),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    final isAllTheDay = event.start == null;
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    final local = Localizations.localeOf(context).languageCode;
    final dateFormat = DateFormat.yMd(local);
    final timeFormat = DateFormat.Hm(local);
    return Card(
      color: themeData.bottomAppBarColor,
      margin: const EdgeInsets.all(10),
      elevation: 5,
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.event),
            title: Text('${dateFormat.format(event.date)}'),
            subtitle: Text(localization.dueDate),
            trailing: isAllTheDay ? Text(localization.allTheDay) : null,
          ),
          Visibility(
            visible: !isAllTheDay,
            child: ListTile(
//              title: Text(timeFormat.format(event.start)),
                ),
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text(event.subject.title),
            subtitle: Text(localization.subject),
          ),
          ListTile(
            leading: Icon(Icons.schedule),
            title: Text(event.remindMeAt != null
                ? timeFormat.formatDuration(event.remindMeAt)
                : localization.none),
            subtitle: Text(localization.reminder),
          ),
          ListTile(
            leading: Icon(Icons.repeat),
            title:
                Text(localization.repeatModeToString(event.repeatMode.value)),
            subtitle: Text(localization.repeatMode),
          ),
          ListTile(
            leading: Icon(Icons.subject),
            title: Text(
                event.note.trim().isNotEmpty ? event.note : localization.none),
          ),
        ],
      ),
    );
  }

  List<Choice> _choices() {
    final localization = Localization.of(context);
    return [
      Choice(
          title: localization.share,
          icon: Icons.share,
          onSelected: () {
            _share();
          }),
      Choice(
          title: localization.edit,
          icon: Icons.edit,
          onSelected: () {
            _navigateToForm();
          }),
      Choice(
          title: localization.delete,
          icon: Icons.delete,
          onSelected: () {
            _showDeleteDialog();
          }),
    ];
  }

  void _share() {
    Share.share('check out my website https://example.com');
  }

  void _navigateToForm() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider.value(
              value: _subjectsBloc,
              child: BlocProvider.value(
                value: _eventsBloc,
                child: EventFormPage(
                  event: event,
                ),
              ),
            )));
  }

  void _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(Localization.of(context).areYouSure),
            content: Text('${Localization.of(context).delete} ${event.title}'),
            actions: <Widget>[
              FlatButton(
                color: Colors.red[800],
                onPressed: () {
                  _eventsBloc.dispatch(DeleteEvent(event));
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Text(
                  Localization.of(context).delete,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  Localization.of(context).cancel,
                  style: TextStyle(color: Colors.black45),
                ),
              )
            ],
          );
        });
  }
}
