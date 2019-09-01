import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/models.dart';

import 'subject_page.dart';

class SubjectFormPage extends StatefulWidget {
  static const routeName = "/subject/form";
  final Subject subject;
  final bool isCreate;

  SubjectFormPage({Key key, this.subject})
      : isCreate = subject == null,
        super(key: key);

  @override
  _SubjectFormPageState createState() => _SubjectFormPageState(
        isCreate ? Subject() : subject,
      );
}

class _SubjectFormPageState extends State<SubjectFormPage> {
  static const horizontalPad = 16.0;
  static const verticalPad = 24.0;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormBuilderState>();

  Subject _subject;
  bool _autoValidate = false;
  bool _formWasEdited = false;

  _SubjectFormPageState(this._subject) : assert(_subject != null);

  @override
  Widget build(BuildContext context) {
    final subjectBloc = BlocProvider.of<SubjectsBloc>(context);
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    _subject.color ??= themeData.accentColor;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.isCreate
            ? localization.subjectCreate
            : localization.subjectEdit),
        backgroundColor:
            widget.isCreate ? themeData.primaryColor : _subject.color,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _onSubmit(subjectBloc);
              })
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: FormBuilder(
          key: _formKey,
          autovalidate: _autoValidate,
          onWillPop: _warnUserAboutInvalidData,
          child: Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding: const EdgeInsets.symmetric(horizontal: horizontalPad),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: verticalPad),
                  FormBuilderTextField(
                    attribute: 'title',
                    decoration: InputDecoration(
                        icon: Icon(Icons.title),
                        labelText: '${localization.title} *',
                        hintText: localization.enterATitle,
                        border: OutlineInputBorder(),
                        filled: true,
                        alignLabelWithHint: true),
                    onChanged: (value) {
                      _subject.title = value?.trim();
                    },
                    initialValue: _subject.title,
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.min(2)
                    ],
                  ),
                  const SizedBox(height: verticalPad),
                  FormBuilderTextField(
                    attribute: 'teacher',
                    decoration: InputDecoration(
                        icon: Icon(Icons.person_pin),
                        labelText: localization.teacher,
                        hintText: localization.enterTeacherName,
                        border: OutlineInputBorder(),
                        filled: true,
                        alignLabelWithHint: true),
                    initialValue: _subject.teacher,
                    onChanged: (value) {
                      _subject.teacher = value?.trim();
                    },
                  ),
                  const SizedBox(height: verticalPad),
                  Padding(
                    padding: const EdgeInsets.only(left: horizontalPad * 2),
                    child: ListTile(
                      leading: Icon(
                        Icons.color_lens,
                        color: _subject.color,
                      ),
                      title: Text(localization.pickAColor),
                      trailing: CircleColor(
                        color: _subject.color,
                        circleSize: 30,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(localization.pickAColor),
                              content: SingleChildScrollView(
                                child: MaterialColorPicker(
                                  selectedColor: _subject.color,
                                  onColorChange: (color) {
                                    _changeColor(color);
                                  },
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(localization.custom),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text(localization.close),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text(localization.ok),
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
                  const SizedBox(height: verticalPad),
                  FormBuilderTextField(
                    attribute: 'description',
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: localization.subjectDescriptionHint,
                      helperText: localization.subjectDescriptionHelper,
                    ),
                    initialValue: _subject.description,
                    onChanged: (value) {
                      _subject.description = value?.trim();
                    },
                  ),
                  const SizedBox(height: verticalPad),
                  RaisedButton.icon(
                    icon: Icon(Icons.save),
                    color: widget.isCreate
                        ? themeData.accentColor
                        : _subject.color,
                    textColor: Colors.white,
                    elevation: 2,
                    onPressed: () {
                      _onSubmit(subjectBloc);
                    },
                    label: Text(localization.save),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _changeColor(Color color) => setState(() => _subject.color = color);

  void _onSubmit(SubjectsBloc subjectBloc) {
    if (!_saveSubject(subjectBloc)) return;
    if (widget.isCreate)
      Navigator.pushNamed(context, SubjectPage.routeName);
    else
      Navigator.pop(context);
  }

  bool _saveSubject(SubjectsBloc subjectBloc) {
    final localization = Localization.of(context);
    if (!_formKey.currentState.validate()) {
      _autoValidate = true;
      _showInSnackBar(localization.pleaseFixErrors);
      return false;
    }
    // form validated
    final form = _formKey.currentState;
    form.save();
    if (widget.isCreate) {
      subjectBloc.dispatch(AddSubject(_subject));
    } else {
      subjectBloc.dispatch(UpdateSubject(_subject));
    }
    return true;
  }

  void _showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final form = _formKey.currentState;
    final localization = Localization.of(context);
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
}
