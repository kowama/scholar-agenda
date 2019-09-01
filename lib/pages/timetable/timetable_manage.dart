import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/blocs/default_timetable/default_timetable.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/models.dart';

class TimetableManagePage extends StatefulWidget {
  static const routeName = "/timetable/manage";

  TimetableManagePage({Key key}) : super(key: key);

  @override
  _TimetableManagePageState createState() => _TimetableManagePageState();
}

class _TimetableManagePageState extends State<TimetableManagePage> {
  static final dateTimeFormatter = DateFormat("dd/MM/yyyy");
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  bool _autoValidateForm = false;
  TimetableBloc _timetableBloc;
  DefaultTimetableBloc _defaultTimetableBloc;

  @override
  void initState() {
    super.initState();
    _timetableBloc = BlocProvider.of<TimetableBloc>(context);
    _defaultTimetableBloc = BlocProvider.of<DefaultTimetableBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(localization.manageTimetable),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    return Column(
      children: <Widget>[
        ListTile(
          leading: IconButton(
            color: themeData.hintColor,
            icon: Icon(Icons.add_circle),
            onPressed: () {
              _timetableFormDialog();
            },
          ),
          title: Text(localization.createNewTimetable),
        ),
        Divider(
          height: 16,
        ),
        ListTile(
          title: Text(
            localization.yourTimetables,
            style: TextStyle(
              color: themeData.accentColor,
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<TimetableBloc, TimetableState>(
            builder: (BuildContext context, TimetableState state) {
              if (state is TimetablesLoaded) {
                if (state.timetables.isNotEmpty) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemCount: state.timetables.length,
                    itemBuilder: (context, index) => _timetableTile(
                      state.timetables[index],
                    ),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.info,
                        size: 48,
                        color: themeData.hintColor,
                      ),
                      Text(
                        localization.noTimetables,
                        style: themeData.textTheme.subhead
                            .copyWith(color: themeData.hintColor),
                      ),
                    ],
                  ),
                );
              } else if (state is TimetablesLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Center(
                  child: Text(
                    state is ErrorTimetablesNotLoaded
                        ? '$state.error'
                        : localization.errorUnknownState,
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }

  Widget _timetableTile(Timetable timetable) {
    return BlocBuilder<DefaultTimetableBloc, DefaultTimetableState>(
      builder: (BuildContext context, DefaultTimetableState state) {
        final isDefaultTimetable = (state is DefaultTimetableLoaded) &&
            state.timetable.id == timetable.id;

        return Card(
          child: ListTile(
            leading: Icon(Icons.developer_board),
            title: Text(timetable.title),
            subtitle: Text('${dateTimeFormatter.format(timetable.start)}'
                '    ${dateTimeFormatter.format(timetable.end)}'),
            trailing: Icon(isDefaultTimetable
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked),
            onTap: () {
              _timetableOnTap(timetable);
            },
          ),
        );
      },
    );
  }

  void _timetableOnTap(Timetable timetable) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final localization = Localization.of(context);
        return AlertDialog(
          content: Container(
            width: double.maxFinite,
            height: 180,
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text(localization.setAsDefault),
                  onTap: () {
                    _defaultTimetableBloc
                        .dispatch(UpdateDefaultTimetable(timetable));
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text(localization.edit),
                  onTap: () {
                    Navigator.of(context).pop();
                    _timetableFormDialog(timetable: timetable);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text(localization.delete),
                  onTap: () {
                    Navigator.of(context).pop();
                    _deleteDialog(timetable);
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(localization.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _timetableFormDialog({Timetable timetable}) {
    var isCreate = timetable == null;
    timetable ??= Timetable();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          final localization = Localization.of(context);
          return AlertDialog(
            title: Text(isCreate
                ? localization.createNewTimetable
                : localization.editTimetable),
            content: Container(
              width: double.maxFinite,
              height: 200,
              child: FormBuilder(
                key: _formKey,
                autovalidate: _autoValidateForm,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: FormBuilderTextField(
                        initialValue: isCreate ? '' : timetable.title,
                        decoration: InputDecoration(
                          labelText: '${localization.title} *',
                          border: OutlineInputBorder(),
                          hintText: localization.enterATitle,
                        ),
                        validators: [FormBuilderValidators.min(1)],
                        onChanged: (value) {
                          timetable.title = value;
                        },
                        attribute: 'title',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: FormBuilderDateTimePicker(
                        attribute: 'start',
                        inputType: InputType.date,
                        format: dateTimeFormatter,
                        initialValue: isCreate ? null : timetable.start,
                        validators: [FormBuilderValidators.required()],
                        onChanged: (value) {
                          timetable.start = value;
                        },
                        decoration: InputDecoration(
                          hintText: localization.pickAStartDate,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: FormBuilderDateTimePicker(
                        attribute: 'end',
                        format: dateTimeFormatter,
                        inputType: InputType.date,
                        initialValue: isCreate ? null : timetable.end,
                        validators: [FormBuilderValidators.required()],
                        onChanged: (value) {
                          timetable.end = value;
                        },
                        decoration: InputDecoration(
                          hintText: localization.pickAEndDate,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text(localization.save),
                onPressed: () {
                  if (_submitForm(
                    timetable,
                    isCreate: isCreate,
                    errorMessage: localization.formErrorMessage,
                  )) Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(localization.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  bool _submitForm(Timetable timetable,
      {isCreate = true, String errorMessage}) {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidateForm = true;
      if (errorMessage != null) _showInSnackBar(errorMessage);
      return false;
    }
    // form validated
    form.save();
    if (isCreate) {
      _timetableBloc.dispatch(AddTimetable(timetable));
    } else {
      _timetableBloc.dispatch(UpdateTimetable(timetable));
    }
    return true;
  }

  void _deleteDialog(Timetable timetable) {
    final localization = Localization.of(context);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(localization.areYouSure),
            content: Text('${localization.delete} ${timetable.title}'),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                onPressed: () {
                  _timetableBloc.dispatch(DeleteTimetable(timetable));
                  Navigator.of(context).pop();
                },
                child: Text(
                  localization.delete,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  localization.cancel,
                  style: TextStyle(color: Colors.black45),
                ),
              )
            ],
          );
        });
  }

  void _showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 10),
    ));
  }
}
