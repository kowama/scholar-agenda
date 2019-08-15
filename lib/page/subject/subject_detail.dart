import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scholar_agenda/model/subject.dart';
import 'package:scholar_agenda/page/subject/subject_form.dart';

class SubjectDetailPage extends StatefulWidget {
  static const routeName = "/subject/detail";

  final Subject subject;

  SubjectDetailPage({Key key, @required this.subject})
      : assert(subject != null),
        super(key: key);

  @override
  _SubjectDetailPageState createState() => _SubjectDetailPageState();
}

class _SubjectDetailPageState extends State<SubjectDetailPage> {
  bool _dialVisible = true;

  SpeedDial _buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      visible: _dialVisible,
      overlayColor: Colors.black,
      overlayOpacity: .5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: widget.subject.color,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            child: Icon(Icons.edit),
            backgroundColor: widget.subject.color,
            label: 'Edit',
            labelBackgroundColor: Colors.black45,
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SubjectFormPage(subject: widget.subject),
                ),
              );
            }),
        SpeedDialChild(
            child: Icon(Icons.add_circle),
            backgroundColor: widget.subject.color,
            label: 'Add',
            labelBackgroundColor: Colors.black45,
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
            onTap: () => print('FIRST CHILD')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.subject.color,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.account_balance),
                text: 'Overview',
              ),
              Tab(
                icon: Icon(Icons.developer_board),
                text: 'Assignment',
              ),
            ],
          ),
          title: Text(widget.subject.title),
        ),
        body: TabBarView(
          children: [
            _FirstTab(subject: widget.subject),
            Icon(Icons.directions_transit),
          ],
        ),
        floatingActionButton: _buildSpeedDial(),
      ),
    );
  }
}

class _FirstTab extends StatelessWidget {
  static const _horizontalPad = 24.0;
  static const _verticalPad = 16.0;
  final Subject subject;

  const _FirstTab({Key key, this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
          horizontal: _horizontalPad, vertical: _verticalPad),
      children: <Widget>[
        Card(
          child: ListTile(
            leading: Icon(Icons.subject),
            title: Text(subject.title),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.perm_identity),
            title: Text(subject.teacher),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.developer_board),
            title: Text(subject.description),
          ),
        )
      ],
    );
  }
}
