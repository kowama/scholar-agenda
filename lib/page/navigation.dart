import 'package:flutter/material.dart';
import 'package:scholar_agenda/page/settings/settings_page.dart';

import 'agenda/agenda_page.dart';
import 'calendar/calendar.dart';
import 'help_and_feedback/help_and_feedback.dart';
import 'home/home_page.dart';
import 'subject/subject_page.dart';
import 'timetable/timetable_page.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    Key key,
  }) : super(key: key);

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.jpeg'),
            ),
            accountName: Text('kowama'),
            accountEmail: Text('n.kowama@gmail.com'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Overview'),
            onTap: () => _navigateTo(context, HomePage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.view_agenda),
            title: Text('Agenda'),
            onTap: () => _navigateTo(context, AgendaPage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Calendar'),
            onTap: () => _navigateTo(context, CalendarPage.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Subject'),
            onTap: () => _navigateTo(context, SubjectPage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Timetable'),
            onTap: () => _navigateTo(context, TimetablePage.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help and feedback'),
            onTap: () => _navigateTo(context, HelpAndFeedbackPage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => _navigateTo(context, SettingsPage.routeName),
          ),
        ],
      ),
    );
  }
}
