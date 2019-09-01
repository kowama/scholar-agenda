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
  SubjectsBloc _subjectsBloc;

  @override
  void initState() {
    super.initState();
    _subjectsBloc = BlocProvider.of<SubjectsBloc>(context);
    _subjectsBloc.dispatch(LoadSubjects());
  }

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.subject),
      ),
      drawer: NavigationDrawer(),
      body: BlocBuilder<SubjectsBloc, SubjectsState>(builder: (context, state) {
        if (state is SubjectsLoaded) {
          final subjects = state.subjects;
          if (subjects.isNotEmpty) {
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
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.school, size: 64,color: themeData.hintColor),
                Text(
                  localization.noSubject,
                  style: themeData.textTheme.headline
                      .copyWith(color: themeData.hintColor),
                ),
              ],
            ),
          );
        } else if (state is SubjectsLoading) {
          _subjectsBloc.dispatch(LoadSubjects());
          return Center(child: CircularProgressIndicator());
        } else {
          if (state is ErrorSubjectsNotLoaded) {
            print(state.exception);
          }
          return Center(child: Text("error to fecth data"));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToSubjectForm(),
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
                value: _subjectsBloc,
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
                _showDeleteDialog(subject);
              },
            ),
            FlatButton(
              color: Colors.grey,
              child: Text(Localization.of(context).edit,
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToSubjectForm(subject: subject);
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

  void _showDeleteDialog(Subject subject) {
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
                  _subjectsBloc.dispatch(DeleteSubject(subject));
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

  void _navigateToSubjectForm({Subject subject}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return BlocProvider.value(
        value: _subjectsBloc,
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
