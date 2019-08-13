import 'package:flutter/material.dart';
import 'package:scholar_agenda/model/subject.dart';
import 'package:scholar_agenda/page/subject/subject_form.dart';
import 'package:scholar_agenda/service/dao.dart';
import '../navigation.dart';

const String SUBJECT_PAGE_ROUTE = "/subject";

class SubjectPage extends StatefulWidget {
  SubjectPage({Key key}) : super(key: key);
  final String title = "Subjects";

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final _dbService = DbService();

  var _subjects = <Subject>[];

  Future updateList() async {
    await _dbService.initialize();
    var subjects = await _dbService.subject.getAll();
    setState(() {
      _subjects = subjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Todo remove this
    updateList();
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
                  subject: _subjects[index], item: _subjects[index]),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, SUBJECT_FORM_ROUTE),
        tooltip: 'Action',
        child: Icon(Icons.add),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  const SubjectCard(
      {Key key,
      this.subject,
      this.onTap,
      @required this.item,
      this.selected: false})
      : super(key: key);

  final Subject subject;
  final VoidCallback onTap;
  final Subject item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.display1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Card(
        child: ListTile(
      leading: Icon(Icons.school, color: subject.color),
      title: Text(subject.title),
      subtitle: Text(subject.teacher != null ? subject.teacher : 'none'),
      trailing: Icon(
        Icons.details,
        color: subject.color,
      ),
    ));
  }
}
