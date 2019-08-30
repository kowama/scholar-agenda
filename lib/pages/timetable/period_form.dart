import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/models.dart';

import 'timetable_page.dart';

class PeriodFormPage extends StatefulWidget {
  static const routeName = "/timetable/period/form";

  final Period period;
  final bool isCreate;
  final Timetable timetable;

  PeriodFormPage({Key key, @required this.timetable, this.period})
      : isCreate = period == null,
        super(key: key);

  @override
  _PeriodFormPageState createState() => _PeriodFormPageState(
        period: isCreate ? Period() : period,
      );
}

class _PeriodFormPageState extends State<PeriodFormPage> {
  static const _horizontalPad = 16.0;
  static const _verticalPad = 16.0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormBuilderState>();
  TimetablePeriodsBloc _timetablePeriodsBloc;
  SubjectsBloc _subjectsBloc;

  Period period;
  List<Subject> subjects;
  bool _autoValidate = false;
  bool _formWasEdited = false;

  _PeriodFormPageState({this.subjects, this.period}) : assert(period != null);

  @override
  void initState() {
    super.initState();
    _timetablePeriodsBloc = BlocProvider.of<TimetablePeriodsBloc>(context);
    _subjectsBloc = BlocProvider.of<SubjectsBloc>(context);
    _subjectsBloc..dispatch(LoadSubjects());
  }

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.isCreate
            ? localization.createPeriod
            : localization.editPeriod),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _onSubmitButtonPressed)
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: FormBuilder(
          key: formKey,
          autovalidate: _autoValidate,
          onWillPop: _warnUserAboutInvalidData,
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: _horizontalPad),
              child: Column(
                children: [
                  const SizedBox(height: _verticalPad),
                  BlocBuilder<SubjectsBloc, SubjectsState>(
                    builder: (context, state) {
                      if (state is SubjectsLoaded) {
                        return FormBuilderDropdown(
                          attribute: "subject",
                          decoration: InputDecoration(
                            labelText: "Subject",
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
                            period.subject = value;
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
                  FormBuilderDropdown(
                    attribute: "day",
                    decoration: InputDecoration(
                      labelText: "Day",
                      border: OutlineInputBorder(),
                    ),
                    hint: Text(localization.pickADay),
                    validators: [FormBuilderValidators.required()],
                    items: List.generate(7, (index) => ++index)
                        .map((day) => DropdownMenuItem(
                              value: day,
                              child:
                                  Text(Localization.of(context).dayOfWeek(day)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      period.dayOfWeek = value;
                    },
                  ),
                  const SizedBox(height: _verticalPad),
                  FormBuilderDateTimePicker(
                    attribute: "Start",
                    inputType: InputType.time,
                    format: DateFormat("HH:mm"),
                    decoration: InputDecoration(
                      labelText: "Sart",
                      border: OutlineInputBorder(),
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onChanged: (value) {
                      period.start = value;
                    },
                  ),
                  const SizedBox(height: _verticalPad),
                  FormBuilderDateTimePicker(
                    attribute: "end",
                    inputType: InputType.time,
                    format: DateFormat("HH:mm"),
                    decoration: InputDecoration(
                      labelText: "End",
                      border: OutlineInputBorder(),
                    ),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    onChanged: (value) {
                      period.end = value;
                    },
                  ),
                  const SizedBox(height: _verticalPad),
                  FormBuilderTextField(
                    attribute: "room",
                    decoration: InputDecoration(
                      labelText: "Room",
                      hintText: 'Enter a room name',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: '',
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(50),
                    ],
                    onChanged: (value) {
                      period.location = value;
                    },
                  ),
                  const SizedBox(height: _verticalPad),
                  RaisedButton.icon(
                    icon: Icon(Icons.save),
                    color: Colors.indigo,
                    textColor: Colors.white,
                    elevation: 2,
                    onPressed: _onSubmitButtonPressed,
                    label: Text(Localization.of(context).save),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _savePeriod() {
    if (!formKey.currentState.validate()) {
      _autoValidate = true;
      _showInSnackBar('Please fix the errors in red before submitting.');
      return false;
    }
    // form validated
    final form = formKey.currentState;
    period.timetable = widget.timetable;
    form.save();
    if (widget.isCreate) {
      _timetablePeriodsBloc.dispatch(AddPeriod(period));
    } else {
      _timetablePeriodsBloc.dispatch(UpdatePeriod(period));
    }
    return true;
  }

  void _onSubmitButtonPressed() {
    if (!_savePeriod()) return;
    if (widget.isCreate)
      Navigator.pushNamed(context, TimetablePage.routeName);
    else
      Navigator.pop(context);
  }

  void _showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final form = formKey.currentState;
    if (form == null || !_formWasEdited || form.validate()) return true;

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('This form has errors'),
              content: const Text('Really leave this form?'),
              actions: <Widget>[
                FlatButton(
                  child: const Text('YES'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: const Text('NO'),
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
}
