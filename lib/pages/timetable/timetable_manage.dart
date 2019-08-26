//import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:scholar_agenda/localization/localization.dart';
//import 'package:scholar_agenda/model/timetable.dart';
//import 'package:scholar_agenda/service/dao.dart';
//
//class TimetableManagePage extends StatefulWidget {
//  static const routeName = "/timetable/manage";
//
//  TimetableManagePage({Key key}) : super(key: key);
//
//  @override
//  _TimetableManagePageState createState() => _TimetableManagePageState();
//}
//
//class _TimetableManagePageState extends State<TimetableManagePage> {
//  static final dateTimeFormatter = DateFormat("dd/MM/yyyy");
//  final _scaffoldKey = GlobalKey<ScaffoldState>();
//  final _formKey = GlobalKey<FormState>();
//  final _dbService = DbService();
//  List<Timetable> _timetables = <Timetable>[];
//  Timetable _defaultTimetable;
//
//  bool _autoValidateForm = false;
//
//  @override
//  Widget build(BuildContext context) {
//    _updateTimetables();
//    return Scaffold(
//      key: _scaffoldKey,
//      appBar: AppBar(
//        title: Text(Localization.of(context).manageTimetable),
//      ),
//      body: Column(
//        children: <Widget>[
//          ListTile(
//            leading: IconButton(
//              icon: Icon(Icons.add),
//              onPressed: () {
//                _showTimetableForm();
//              },
//            ),
//            title: Text(Localization.of(context).createNewTimetable),
//          ),
//          Divider(
//            height: 16,
//          ),
//          ListTile(
//              title: Text(
//            Localization.of(context).yourTimetables,
//            style: TextStyle(
//              color: Theme.of(context).accentColor,
//            ),
//          )),
//          Expanded(
//            child: ListView.builder(
//              padding: EdgeInsets.symmetric(horizontal: 4.0),
//              itemCount: _timetables.length,
//              itemBuilder: (context, index) => _buildTimetableTile(
//                  _timetables[index],
//                  isDefault: _timetables[index] == _defaultTimetable),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//
//  Widget _buildTimetableTile(Timetable timetable, {bool isDefault = false}) {
//    return Card(
//      child: ListTile(
//        leading: Icon(Icons.developer_board),
//        title: Text(timetable.title),
//        subtitle: Text('${dateTimeFormatter.format(timetable.start)}'
//            '    ${dateTimeFormatter.format(timetable.end)}'),
//        trailing: Icon(isDefault
//            ? Icons.radio_button_checked
//            : Icons.radio_button_unchecked),
//        onTap: () {
//          showDialog(
//            context: context,
//            builder: (BuildContext context) {
//              // return object of type Dialog
//              return AlertDialog(
//                content: Container(
//                  width: double.maxFinite,
//                  height: 150,
//                  child: ListView(
//                    children: <Widget>[
//                      ListTile(
//                        leading: Icon(Icons.check_circle),
//                        title: Text(Localization.of(context).setAsDefault),
//                        onTap: () {
//                          Navigator.of(context).pop();
//                          _setAsDefault(timetable);
//                        },
//                      ),
//                      ListTile(
//                        leading: Icon(Icons.edit),
//                        title: Text(Localization.of(context).edit),
//                        onTap: () {
//                          Navigator.of(context).pop();
//                          _showTimetableForm(timetable: timetable);
//                        },
//                      ),
//                      ListTile(
//                        leading: Icon(Icons.delete),
//                        title: Text(Localization.of(context).delete),
//                        onTap: () {
//                          Navigator.of(context).pop();
//                          _showDeleteDialog(context, timetable);
//                        },
//                      ),
//                    ],
//                  ),
//                ),
//                actions: <Widget>[
//                  // usually buttons at the bottom of the dialog
//                  new FlatButton(
//                    child: new Text(Localization.of(context).close),
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                  ),
//                ],
//              );
//            },
//          );
//        },
//      ),
//    );
//  }
//
//  void _updateTimetables() async {
//    var timetables = await _dbService.timetable.getAll();
//    _defaultTimetable ??= timetables.isEmpty ? null : timetables.first;
//    setState(() {
//      _timetables = timetables;
//    });
//  }
//
//  void _showTimetableForm({Timetable timetable}) {
//    var isCreate = timetable == null;
//    timetable ??= Timetable();
//
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return AlertDialog(
//            title: Text(isCreate
//                ? Localization.of(context).createNewTimetable
//                : Localization.of(context).editTimetable),
//            content: Container(
//              width: double.maxFinite,
//              height: 320,
//              child: Form(
//                key: _formKey,
//                autovalidate: _autoValidateForm,
//                child: ListView(
//                  children: <Widget>[
//                    Padding(
//                      padding: const EdgeInsets.all(4),
//                      child: TextFormField(
//                        initialValue: isCreate ? '' : timetable.title,
//                        decoration: InputDecoration(
//                          labelText: '${Localization.of(context).title} *',
//                          hintText: Localization.of(context).enterATitle,
//                        ),
//                        validator: (value) {
//                          if (value == null || value.isEmpty) {
//                            return Localization.of(context).valueIsRequired;
//                          }
//                          return null;
//                        },
//                        onSaved: (value) {
//                          timetable.title = value;
//                        },
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(4),
//                      child: DateTimeField(
//                        format: dateTimeFormatter,
//                        initialValue: isCreate ? null : timetable.start,
//                        onShowPicker: (context, currentValue) {
//                          return showDatePicker(
//                              context: context,
//                              firstDate: DateTime(1900),
//                              initialDate: currentValue ?? DateTime.now(),
//                              lastDate: DateTime(2100));
//                        },
//                        validator: (value) {
//                          if (value == null) {
//                            return Localization.of(context).valueIsRequired;
//                          }
//                          return null;
//                        },
//                        onSaved: (value) {
//                          timetable.start = value;
//                        },
//                        decoration: InputDecoration(
//                          hintText: Localization.of(context).pickAStartDate,
//                        ),
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(4),
//                      child: DateTimeField(
//                        format: dateTimeFormatter,
//                        initialValue: isCreate ? null : timetable.end,
//                        onShowPicker: (context, currentValue) {
//                          return showDatePicker(
//                              context: context,
//                              firstDate: DateTime(1900),
//                              initialDate: currentValue ?? DateTime.now(),
//                              lastDate: DateTime(2100));
//                        },
//                        validator: (value) {
//                          if (value == null) {
//                            return Localization.of(context).valueIsRequired;
//                          }
//                          return null;
//                        },
//                        onSaved: (value) {
//                          timetable.end = value;
//                        },
//                        decoration: InputDecoration(
//                          hintText: Localization.of(context).pickAEndDate,
//                        ),
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.all(4),
//                      child: TextFormField(
//                        keyboardType: TextInputType.multiline,
//                        maxLines: 4,
//                        decoration: const InputDecoration(
//                          border: OutlineInputBorder(),
//                          hintText:
//                              'somme description or other details about the timetable',
//                          labelText: 'Add a note text',
//                        ),
//                        initialValue: isCreate ? '' : timetable.description,
//                        onSaved: (String value) {
//                          timetable.description = value;
//                        },
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//            actions: <Widget>[
//              // usually buttons at the bottom of the dialog
//              new FlatButton(
//                child: new Text(Localization.of(context).save),
//                onPressed: () async {
//                  if (await _submitForm(timetable,
//                      isCreate: isCreate,
//                      errorMessage: Localization.of(context).formErrorMessage))
//                    Navigator.of(context).pop();
//                },
//              ),
//              new FlatButton(
//                child: new Text(Localization.of(context).close),
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//              ),
//            ],
//          );
//        });
//  }
//
//  Future<bool> _submitForm(Timetable timetable,
//      {isCreate = true, String errorMessage}) async {
//    if (!_formKey.currentState.validate()) {
//      _autoValidateForm = true;
//      if (errorMessage != null) _showInSnackBar(errorMessage);
//      return false;
//    }
//    // form validated
//    final FormState form = _formKey.currentState;
//    form.save();
//    if (isCreate) {
//      _dbService.timetable.insert(timetable);
//    } else {
//      _dbService.timetable.update(timetable);
//    }
//    return true;
//  }
//
//  void _showInSnackBar(String value) {
//    _scaffoldKey.currentState.showSnackBar(SnackBar(
//      content: Text(value),
//    ));
//  }
//
//  void _setAsDefault(Timetable timetable) {
//    setState(() {
//      _defaultTimetable = timetable;
//    });
//  }
//
//  void _showDeleteDialog(BuildContext context, Timetable timetable) {
//    showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            title: Text(Localization.of(context).areYouSure),
//            content:
//                Text('${Localization.of(context).delete} ${timetable.title}'),
//            actions: <Widget>[
//              FlatButton(
//                color: Colors.red,
//                onPressed: () {
//                  _dbService.timetable.delete(timetable.id);
//                  Navigator.of(context).pop();
//                },
//                child: Text(
//                  Localization.of(context).delete,
//                  style: TextStyle(color: Colors.white),
//                ),
//              ),
//              FlatButton(
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//                child: Text(
//                  Localization.of(context).cancel,
//                  style: TextStyle(color: Colors.black45),
//                ),
//              )
//            ],
//          );
//        });
//  }
//}
