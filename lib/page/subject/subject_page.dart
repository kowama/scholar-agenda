import 'package:flutter/material.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/model/subject.dart';
import 'package:scholar_agenda/page/subject/subject_detail.dart';
import 'package:scholar_agenda/page/subject/subject_form.dart';
import 'package:scholar_agenda/service/dao.dart';
import '../navigation.dart';

class SubjectPage extends StatefulWidget {
  static const String routeName = "/subject";
  final String title = "Subjects";

  SubjectPage({Key key}) : super(key: key);

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final _dbService = DbService();

  var _subjects = <Subject>[];

  Future<void> _updateList() async {
    await _dbService.initialize();
    var subjects = await _dbService.subject.getAll();
    setState(() {
      _subjects = subjects;
    });
  }

  void _onListItemTap(BuildContext context, Subject subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectDetailPage(subject: subject),
      ),
    );
  }

  Future<void> _onListIemLongPress(
      BuildContext context, Subject subject) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          semanticLabel: subject.title,
          titlePadding: EdgeInsets.all(0.0),
          title: Container(
              color: subject.color,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Text(
                  subject.title,
                  style: TextStyle(color: Colors.white),
                ),
              )),
          content: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.perm_identity),
                title: Text(subject.teacher),
              ),
              Divider(),
            ],
          )),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              child: Text(
                Localization.of(context).delete,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _showDeleteDialog(context, subject);
              },
            ),
            FlatButton(
              color: Colors.grey,
              child: Text(Localization.of(context).edit,
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToSubjectForm(context, subject);
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text(Localization.of(context).close,
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, Subject subject) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(Localization.of(context).areYouSure),
            content:
                Text('${Localization.of(context).delete} ${subject.title}'),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                onPressed: () {
                  _dbService.subject.delete(subject.id);
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

  void _navigateToSubjectForm(BuildContext context, Subject subject) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SubjectFormPage(
                  subject: subject,
                )));
  }

  @override
  Widget build(BuildContext context) {
    _updateList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: NavigationDrawer(),
      body: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          children: List.generate(_subjects.length, (index) {
            return Center(
              child: SubjectCard(
                subjectItem: _subjects[index],
                onItemTap: () {
                  _onListItemTap(context, _subjects[index]);
                },
                onItemLongPress: () {
                  _onListIemLongPress(context, _subjects[index]);
                },
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToSubjectForm(context, null),
        tooltip: Localization.of(context).action,
        child: Icon(Icons.add),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  const SubjectCard(
      {Key key,
      @required this.subjectItem,
      @required this.onItemTap,
      @required this.onItemLongPress,
      this.selected: false})
      : assert(subjectItem != null &&
            onItemTap != null &&
            onItemLongPress != null),
        super(key: key);

  final Subject subjectItem;
  final VoidCallback onItemTap;
  final VoidCallback onItemLongPress;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Card(
      child: ListTile(
        leading: Icon(Icons.school, color: subjectItem.color),
        title: Text(subjectItem.title),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            subjectItem.teacher != null ? subjectItem.teacher : 'none',
          ),
        ),
        trailing: Icon(
          Icons.details,
          color: subjectItem.color,
        ),
        onTap: onItemTap,
        onLongPress: onItemLongPress,
      ),
    );
  }
}
