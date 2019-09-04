import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/models.dart';

import 'agenda_page.dart';

class EventFormPage extends StatefulWidget {
  static const routeName = '/agenda/event/form';
  final Event event;
  final EventType eventType;
  final isCreate;

  const EventFormPage({Key key, this.event, this.eventType})
      : assert(event != null || eventType != null),
        isCreate = event == null,
        super(key: key);

  @override
  _EventFormPageState createState() =>
      _EventFormPageState(isCreate ? Event(type: eventType) : event);
}

class _EventFormPageState extends State<EventFormPage> {
  static const _horizontalPad = 16.0;
  static const _verticalPad = 16.0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormBuilderState>();
  Event _event;
  bool _autoValidate = false;
  bool _formWasEdited = false;
  SubjectsBloc _subjectsBloc;
  EventsBloc _eventsBloc;
  bool _allTheDay;
  Duration _timeBefore;

  _EventFormPageState(this._event)
      : _allTheDay = _event.type == EventType.homework;

  @override
  void initState() {
    super.initState();
    _subjectsBloc = BlocProvider.of<SubjectsBloc>(context);
    _eventsBloc = BlocProvider.of<EventsBloc>(context);
    _subjectsBloc.dispatch(LoadSubjects());
    _eventsBloc.dispatch(LoadEvents());
  }

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          '${widget.isCreate ? localization.create : localization.edit} '
          '${localization.eventType(_event.typeValue).toLowerCase()}',
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _onSubmit)
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: _form(),
      ),
    );
  }

  Widget _form() {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    final local = Localizations.localeOf(context).languageCode;
    final reminders = _reminders();
    return FormBuilder(
      key: formKey,
      autovalidate: _autoValidate,
      onWillPop: _warnUserAboutInvalidData,
      child: Scrollbar(
        child: SingleChildScrollView(
          dragStartBehavior: DragStartBehavior.down,
          padding: const EdgeInsets.symmetric(horizontal: _horizontalPad),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: _verticalPad),
              FormBuilderTextField(
                attribute: "title",
                decoration: InputDecoration(
                  labelText: '${localization.title} *',
                  hintText: localization.titleHint,
                  border: OutlineInputBorder(),
                ),
                initialValue: _event.title,
                validators: [
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxLength(50),
                ],
                onChanged: (value) {
                  _event.title = value;
                },
              ),
              const SizedBox(height: _verticalPad),
              BlocBuilder<SubjectsBloc, SubjectsState>(
                builder: (context, state) {
                  if (state is SubjectsLoaded) {
                    return FormBuilderDropdown(
                      initialValue: _event.subject,
                      attribute: "subject",
                      decoration: InputDecoration(
                        labelText: localization.subject,
                        border: OutlineInputBorder(),
                      ),
                      hint: Text(localization.pickASubject),
                      validators: [FormBuilderValidators.required()],
                      items: state.subjects
                          .map((subject) => DropdownMenuItem(
                                value: subject,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(subject.title),
                                    CircleAvatar(
                                      radius: 4,
                                      backgroundColor: subject.color,
                                    )
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        _event.subject = value;
                      },
                    );
                  } else {
                    return Center(
                      child: (state is SubjectsLoading)
                          ? CircularProgressIndicator()
                          : Text(localization.errorUnableToLoadData),
                    );
                  }
                },
              ),
              const SizedBox(height: _verticalPad),
              FormBuilderDateTimePicker(
                attribute: "date",
                initialValue: _event.date,
                inputType: InputType.date,
                format: DateFormat.yMMMMd(local),
                decoration: InputDecoration(
                  labelText: localization.dateHint,
                  border: OutlineInputBorder(),
                ),
                validators: [
                  FormBuilderValidators.required(),
                ],
                onChanged: (value) {
                  _event.date = value;
                },
              ),
              const SizedBox(height: _verticalPad),
              FormBuilderCheckbox(
                attribute: "all_day",
                initialValue: _allTheDay,
                label: Text("All day"),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _allTheDay = value;
                  });
                },
              ),
              const SizedBox(height: _verticalPad),
              Visibility(
                visible: !_allTheDay,
                child: FormBuilderDateTimePicker(
                  attribute: "start",
                  initialValue: _event.start,
                  inputType: InputType.time,
                  format: DateFormat.Hm(local),
                  decoration: InputDecoration(
                    labelText: localization.start,
                    border: OutlineInputBorder(),
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  onChanged: (value) {
                    _event.start = _allTheDay ? null : value;
                  },
                ),
              ),
              const SizedBox(height: _verticalPad),
              Visibility(
                visible: !_allTheDay,
                child: FormBuilderDateTimePicker(
                  attribute: "end",
                  initialValue: _event.end,
                  inputType: InputType.time,
                  format: DateFormat.Hm(local),
                  decoration: InputDecoration(
                    labelText: localization.end,
                    border: OutlineInputBorder(),
                  ),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  onChanged: (value) {
                    _event.end = _allTheDay ? null : value;
                  },
                ),
              ),
              const SizedBox(height: _verticalPad),
              Visibility(
                visible: _allTheDay,
                child: FormBuilderDropdown(
                  attribute: "remindMeAt",
                  hint: Text('Remind me '),
                  decoration: InputDecoration(
                    labelText: 'Remind me ',
                    border: OutlineInputBorder(),
                  ),
                  validators: [FormBuilderValidators.required()],
                  items: reminders
                      .map((reminder) => DropdownMenuItem<TimeSpan>(
                            value: reminder,
                            child: Text(reminder.label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value.duration) _timeBefore = value.duration;
                  },
                ),
              ),
              const SizedBox(height: _verticalPad),
              FormBuilderTextField(
                attribute: "description",
                decoration: InputDecoration(
                  labelText: localization.description,
                  hintText: localization.descriptionHint,
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                initialValue: _event.note,
                validators: [
                  FormBuilderValidators.maxLength(50),
                ],
                onChanged: (value) {
                  _event.note = value;
                },
              ),
              const SizedBox(height: _verticalPad),
              RaisedButton.icon(
                icon: Icon(Icons.save),
                color: themeData.accentColor,
                textColor: themeData.cardColor,
                elevation: 2,
                onPressed: _onSubmit,
                label: Text(localization.save),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _saveEvent() {
    final localization = Localization.of(context);
    if (!formKey.currentState.validate()) {
      _autoValidate = true;
      _showInSnackBar(localization.pleaseFixErrors);
      return false;
    }
    if (_event.end.isBefore(_event.end)) {
      _showInSnackBar(localization.startCantBeBeforeAfter, color: Colors.red);
    }
    // form validated
    final form = formKey.currentState;
    form.save();
    _event.remindMeAt = _timeBefore == null
        ? null
        : _allTheDay
            ? _event.date.subtract(_timeBefore)
            : _event.start.subtract(_timeBefore);

    if (widget.isCreate) {
      _eventsBloc.dispatch(AddEvent(_event));
    } else {
      _eventsBloc.dispatch(UpdateEvent(_event));
    }
    return true;
  }

  void _onSubmit() {
    if (!_saveEvent()) return;
    Navigator.pop(context);
    Navigator.pushNamed(context, AgendaPage.routeName);
  }

  void _showInSnackBar(String message, {Color color}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: color),
      ),
    ));
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final localization = Localization.of(context);
    final form = formKey.currentState;
    if (form == null || !_formWasEdited || form.validate()) return true;

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(localization.formHasErrors),
              content: Text(localization.leaveForm),
              actions: <Widget>[
                FlatButton(
                  child: Text(localization.yes),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: Text(localization.no),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  List<TimeSpan> _reminders() {
    return [
      TimeSpan(label: 'none'), //null reminder
      TimeSpan(label: 'At time', duration: Duration(seconds: 5)),
      TimeSpan(label: '1 m', duration: Duration(minutes: 1)),
      TimeSpan(label: '5 m', duration: Duration(minutes: 1)),
      TimeSpan(label: '15 m', duration: Duration(minutes: 1)),
      TimeSpan(label: '30 m', duration: Duration(minutes: 1)),
      TimeSpan(label: '1 h', duration: Duration(minutes: 1)),
      TimeSpan(label: '5 h', duration: Duration(minutes: 1)),
      TimeSpan(label: '1 day', duration: Duration(minutes: 1)),
      TimeSpan(label: '2 days', duration: Duration(minutes: 1)),
      TimeSpan(label: '1 week', duration: Duration(minutes: 1)),
      TimeSpan(label: '2 weeks', duration: Duration(minutes: 1)),
    ];
  }
}

class TimeSpan {
  final label;
  final duration;

  TimeSpan({this.label, this.duration});
}
