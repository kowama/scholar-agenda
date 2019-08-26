import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_agenda/blocs/subject/bloc.dart';
import 'package:scholar_agenda/blocs/subject/subject_bloc.dart';
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
          final subjectBloc = BlocProvider.of<SubjectBloc>(context);
          return AlertDialog(
            title: Text(Localization.of(context).areYouSure),
            content:
                Text('${Localization.of(context).delete} ${subject.title}'),
            actions: <Widget>[
              FlatButton(
                color: Colors.red,
                onPressed: () {
                  subjectBloc.dispatch(DeleteSubjectEvent(subject));
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
    final subjectBloc = BlocProvider.of<SubjectBloc>(context);
    return BlocBuilder<SubjectBloc, SubjectState>(
      builder: (context, subjectState) {
        if (subjectState is LoadedSubjectsState) {
          final subjects = subjectState.subjects;
          return Scaffold(
            appBar: AppBar(
              title: Text(Localization.of(context).subject),
            ),
            drawer: NavigationDrawer(),
            body: ListView(
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                children: List.generate(subjects.length, (index) {
                  return Center(
                    child: SubjectCard(
                      subjectItem: subjects[index],
                      onItemTap: () {
                        _onListItemTap(context, subjects[index]);
                      },
                      onItemLongPress: () {
                        _onListIemLongPress(context, subjects[index]);
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
        } else {
          subjectBloc.dispatch(LoadSubjectsEvent());
          if (subjectState is NotLoadedSubjectsState) {
            print(subjectState.error);
          }
          return Center(child: CircularProgressIndicator());
        }
      },
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
    return Card(
      color: selected
          ? Theme.of(context).selectedRowColor
          : Theme.of(context).scaffoldBackgroundColor,
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
