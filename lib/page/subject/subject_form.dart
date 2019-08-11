import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:scholar_agenda/model/subject.dart';
import 'package:scholar_agenda/page/subject/subject_page.dart';

const String SUBJECT_FORM_ROUTE = "/subject/form";

class SubjectForm extends StatefulWidget {
  SubjectForm({Key key}) : super(key: key);
  final String title = 'Subject Form';
  final Subject _subject = Subject();

  @override
  _SubjectFormState createState() => _SubjectFormState();
}

class _SubjectFormState extends State<SubjectForm> {
  Color _currentColor = Colors.amber;

  void _changeColor(Color color) => setState(() => _currentColor = color);

  void _saveSubject() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                _saveSubject();
                Navigator.pushNamed(context, SUBJECT_PAGE_ROUTE);
              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.title),
            title: TextField(
              decoration: InputDecoration(
                hintText: "Title",
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.color_lens,
              color: _currentColor,
            ),
            title: Text('Pick a color'),
            trailing: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 50),
              width: 100,
              height: 30,
              color: _currentColor,
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
          Divider(
            height: 1.0,
          ),
          ListTile(
            leading: Icon(Icons.room),
            title: TextField(
              decoration: InputDecoration(
                hintText: "Location",
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: TextField(
              decoration: InputDecoration(
                hintText: "Teacher",
              ),
            ),
          ),
          Divider(
            height: 1.0,
          ),
          ListTile(
            title: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "add note",
              ),
            ),
          )
        ],
      ),
    );
  }
}
