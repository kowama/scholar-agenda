import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:scholar_agenda/model/subject.dart';
import 'package:scholar_agenda/page/subject/subject_page.dart';

const String SUBJECT_FORM_ROUTE = "/subject/form";

class SubjectForm extends StatefulWidget {
  SubjectForm({Key key}) : super(key: key);
  final String title = 'Subject Form';

  @override
  _SubjectFormState createState() => _SubjectFormState();
}

class _SubjectFormState extends State<SubjectForm> {
  static const _widthOffset = 16.0;
  static const _separationHeight = 24.0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  Subject _subject = Subject();
  Color _currentColor = Colors.amber;
  bool _autovalidate = false;
  bool _formWasEdited = false;

  void _changeColor(Color color) => setState(() => _currentColor = color);

  bool _saveSubject() {
    if (!_formKey.currentState.validate()) {
      _autovalidate = true;
      showInSnackBar('Please fix the errors in red before submitting.');
      return false;
    }
    final FormState form = _formKey.currentState;
    form.save();
    showInSnackBar('${_subject.title}\'s  teacher is ${_subject.teacher}');
    return true;
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  String _validateRequiredField(String value) {
    _formWasEdited = true;
    if (value.isEmpty) return 'Field is required.';
    return null;
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (!_saveSubject()) return;
                Navigator.pushNamed(context, SUBJECT_PAGE_ROUTE);
              })
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: _autovalidate,
          onWillPop: _warnUserAboutInvalidData,
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: _widthOffset),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: _separationHeight),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.title),
                        labelText: 'Title *',
                        hintText: "Enter the subject title",
                        border: UnderlineInputBorder(),
                        filled: true,
                        alignLabelWithHint: true),
                    onSaved: (String value) {
                      _subject.title = value;
                    },
                    validator: _validateRequiredField,
                  ),
                  const SizedBox(height: _separationHeight),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.person_pin),
                        labelText: 'Teacher',
                        hintText: "Enter the teacher name",
                        border: UnderlineInputBorder(),
                        filled: true,
                        alignLabelWithHint: true),
                    onSaved: (String value) {
                      _subject.teacher = value;
                    },
                  ),
                  const SizedBox(height: _separationHeight),
                  Padding(
                    padding: const EdgeInsets.only(left: _widthOffset * 2),
                    child: ListTile(
                      leading: Icon(
                        Icons.color_lens,
                        color: _currentColor,
                      ),
                      title: Text('Pick a color'),
                      trailing: CircleColor(
                        color: _currentColor,
                        circleSize: 30,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Select a color'),
                              content: SingleChildScrollView(
                                child: MaterialColorPicker(
                                  selectedColor: _currentColor,
                                  onColorChange: _changeColor,
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Custom"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text("Close"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: _separationHeight),
                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          'somme description or other details about the subject',
                      helperText: 'a short description text about the subject',
                      labelText: 'Add note text',
                    ),
                  ),
                  const SizedBox(height: _separationHeight),
                  RaisedButton(
                    color: Colors.indigo,
                    textColor: Colors.white,
                    elevation: 2,
                    onPressed: () {
                      if (!_saveSubject()) return;
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
