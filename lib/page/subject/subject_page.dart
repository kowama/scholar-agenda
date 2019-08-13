import 'package:flutter/material.dart';
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
                subjectItem: _subjects[index],
                onItemTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SubjectDetailPage(subject: _subjects[index]),
                    ),
                  );
                },
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => SubjectFormPage())),
        tooltip: 'Action',
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
      this.selected: false})
      : super(key: key);

  final Subject subjectItem;
  final VoidCallback onItemTap;
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
        subtitle:
            Text(subjectItem.teacher != null ? subjectItem.teacher : 'none'),
        trailing: Icon(
          Icons.details,
          color: subjectItem.color,
        ),
        onTap: onItemTap,
      ),
    );
  }
}
