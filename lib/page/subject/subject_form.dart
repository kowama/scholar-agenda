import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:scholar_agenda/model/subject.dart';
import 'package:scholar_agenda/page/subject/subject_page.dart';
import 'package:scholar_agenda/service/dao.dart';

class SubjectFormPage extends StatefulWidget {
  static const routeName = "/subject/form";
  final String title;
  final Subject subject;
  final bool isCreate;

  SubjectFormPage({Key key, this.subject})
      : isCreate = subject == null,
        title = subject == null ? 'Subject Create' : 'Subject Edit',
        super(key: key);

  @override
  _SubjectFormPageState createState() => _SubjectFormPageState(
      subject: isCreate ? Subject(color: Colors.indigo) : subject);
}

class _SubjectFormPageState extends State<SubjectFormPage> {
  static const _horizontalPad = 16.0;
  static const _verticalPad = 24.0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _dbService = DbService();

  Subject subject;
  bool _autoValidate = false;
  bool _formWasEdited = false;

  _SubjectFormPageState({this.subject}) : assert(subject != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.isCreate ? Colors.indigo : subject.color,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _onSubmitButtonPressed)
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          onWillPop: _warnUserAboutInvalidData,
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: _horizontalPad),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: _verticalPad),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.title),
                        labelText: 'Title *',
                        hintText: "Enter the subject title",
                        border: UnderlineInputBorder(),
                        filled: true,
                        alignLabelWithHint: true),
                    onSaved: (String value) {
                      subject.title = value;
                    },
                    initialValue: widget.isCreate ? '' : subject.title,
                    validator: _validateRequiredField,
                  ),
                  const SizedBox(height: _verticalPad),
                  TextFormField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.person_pin),
                        labelText: 'Teacher',
                        hintText: "Enter the teacher name",
                        border: UnderlineInputBorder(),
                        filled: true,
                        alignLabelWithHint: true),
                    initialValue: widget.isCreate ? '' : subject.teacher,
                    onSaved: (String value) {
                      subject.teacher = value;
                    },
                  ),
                  const SizedBox(height: _verticalPad),
                  Padding(
                    padding: const EdgeInsets.only(left: _horizontalPad * 2),
                    child: ListTile(
                      leading: Icon(
                        Icons.color_lens,
                        color: subject.color,
                      ),
                      title: Text('Pick a color'),
                      trailing: CircleColor(
                        color: subject.color,
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
                                  selectedColor: subject.color,
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
                  const SizedBox(height: _verticalPad),
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
                    initialValue: widget.isCreate ? '' : subject.description,
                    onSaved: (String value) {
                      subject.description = value;
                    },
                  ),
                  const SizedBox(height: _verticalPad),
                  RaisedButton.icon(
                    icon: Icon(Icons.save),
                    color: widget.isCreate ? Colors.indigo : subject.color,
                    textColor: Colors.white,
                    elevation: 2,
                    onPressed: _onSubmitButtonPressed,
                    label: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _changeColor(Color color) => setState(() => subject.color = color);

  bool _saveSubject() {
    if (!_formKey.currentState.validate()) {
      _autoValidate = true;
      _showInSnackBar('Please fix the errors in red before submitting.');
      return false;
    }
    // form validated
    final FormState form = _formKey.currentState;
    form.save();
    if (widget.isCreate) {
      _dbService.subject.insert(subject);
    } else {
      _dbService.subject.update(subject);
    }
    return true;
  }

  void _onSubmitButtonPressed() {
    if (!_saveSubject()) return;
    if (widget.isCreate)
      Navigator.pushNamed(context, SubjectPage.routeName);
    else
      Navigator.pop(context);
  }

  void _showInSnackBar(String value) {
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
}
