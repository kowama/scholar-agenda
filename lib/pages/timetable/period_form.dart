import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/models.dart';

class PeriodFormPage extends StatefulWidget {
  static const routeName = "/timetable/period/form";

  final String title;
  final Period period;
  final bool isCreate;
  final Timetable timetable;

  PeriodFormPage({Key key, @required this.timetable, this.period})
      : isCreate = period == null,
        title = period == null ? 'Period Create' : 'Period Edit',
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

  Period period;
  List<Subject> subjects;
  bool _autoValidate = false;
  bool _formWasEdited = false;

  _PeriodFormPageState({this.subjects, this.period}) : assert(period != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
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
//                  FutureBuilder<List<Subjects>>(
//                      future: subjects,
//                      builder: (context, snapshot) {
//                        if (snapshot.hasData) {
//                          return FormBuilderDropdown(
//                            attribute: "subject",
//                            decoration: InputDecoration(
//                              labelText: "Subject",
//                              border: OutlineInputBorder(),
//                            ),
//                            hint: Text('Pick a subject'),
//                            validators: [FormBuilderValidators.required()],
//                            items: snapshot.data
//                                .map((subject) => DropdownMenuItem(
//                                      value: subject,
//                                      child: Row(
//                                          mainAxisAlignment:
//                                              MainAxisAlignment.spaceBetween,
//                                          children: <Widget>[
//                                            Text(subject.title),
//                                            CircleAvatar(
//                                              radius: 4,
//                                              backgroundColor: subject.color,
//                                            )
//                                          ]),
//                                    ))
//                                .toList(),
//                            onChanged: (value) {
//                              period.subject = value;
//                            },
//                          );
//                        } else if (snapshot.hasError) {
//                          return Text("${snapshot.error}");
//                        }
//
//                        // By default, show a loading spinner.
//                        return CircularProgressIndicator();
//                      }),
                  const SizedBox(height: _verticalPad),
                  FormBuilderDropdown(
                    attribute: "day",
                    decoration: InputDecoration(
                      labelText: "Day",
                      border: OutlineInputBorder(),
                    ),
                    hint: Text('Pick a day'),
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
                    attribute: "sart",
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
//    if (!formKey.currentState.validate()) {
//      _autoValidate = true;
//      _showInSnackBar('Please fix the errors in red before submitting.');
//      return false;
//    }
//    // form validated
//    final form = formKey.currentState;
//    print(widget.timetable);
//    period.timetable = widget.timetable;
//    form.save();
//    print(period);
//    if (widget.isCreate) {
//      dbService.period.insert(period);
//    } else {
//      dbService.period.update(period);
//    }
    return true;
  }

  void _onSubmitButtonPressed() {
//    print(period);
//    if (!_savePeriod()) return;
//    if (widget.isCreate)
//      Navigator.pushNamed(context, TimetablePage.routeName);
//    else
//      Navigator.pop(context);
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
