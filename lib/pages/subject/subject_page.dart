import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_agenda/blocs/blocs.dart';
import 'package:scholar_agenda/localization/localization.dart';
import 'package:scholar_agenda/models/models.dart';

import '../navigation.dart';
import 'subject_detail.dart';
import 'subject_form.dart';

class SubjectPage extends StatefulWidget {
  static const String routeName = "/subject";

  SubjectPage({Key key}) : super(key: key);

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  SubjectBloc _subjectBloc;

  @override
  void initState() {
    super.initState();
    _subjectBloc = BlocProvider.of<SubjectBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).subject),
      ),
      drawer: NavigationDrawer(),
      body: BlocBuilder<SubjectBloc, SubjectState>(builder: (context, state) {
        if (state is SubjectsLoaded) {
          final subjects = state.subjects;
          return ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            children: List.generate(
              subjects.length,
              (index) {
                return Center(
                  child: SubjectCard(
                    subject: subjects[index],
                    onTap: () {
                      _onListItemTap(context, subjects[index]);
                    },
                    onLongPress: () {
                      _onListIemLongPress(context, subjects[index]);
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is SubjectsLoading) {
          _subjectBloc.dispatch(LoadSubjects());
          return Center(child: CircularProgressIndicator());
        } else {
          if (state is ErrorSubjectsNotLoaded) {
            print(state.exception);
          }
          return Center(child: Text("error to fecth data"));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToSubjectForm(context),
        tooltip: Localization.of(context).action,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onListItemTap(BuildContext context, Subject subject) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BlocProvider.value(
                value: _subjectBloc,
                child: SubjectDetailPage(subject: subject),
              )),
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
                _navigateToSubjectForm(context, subject: subject);
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
                  _subjectBloc.dispatch(DeleteSubject(subject));
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

  void _navigateToSubjectForm(BuildContext context, {Subject subject}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocProvider.value(
        value: _subjectBloc,
        child: SubjectFormPage(
          subject: subject,
        ),
      );
    }));
  }
}

class SubjectCard extends StatelessWidget {
  const SubjectCard(
      {Key key,
      @required this.subject,
      @required this.onTap,
      @required this.onLongPress,
      this.selected: false})
      : assert(subject != null && onTap != null && onLongPress != null),
        super(key: key);

  final Subject subject;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected
          ? Theme.of(context).selectedRowColor
          : Theme.of(context).scaffoldBackgroundColor,
      child: ListTile(
        leading: Icon(Icons.school, color: subject.color),
        title: Text(subject.title),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            subject.teacher,
          ),
        ),
        trailing: Icon(
          Icons.details,
          color: subject.color,
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
