import 'package:flutter/material.dart';
import 'package:scholar_agenda/localization/localization.dart';

import 'agenda/agenda_page.dart';
import 'calendar/calendar.dart';
import 'help_and_feedback/help_and_feedback.dart';
import 'home/home_page.dart';
import 'settings/settings_page.dart';
import 'subject/subject_page.dart';
import 'timetable/timetable_page.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
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
            title: Text(localization.overview),
            onTap: () => _navigateTo(context, HomePage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text(localization.agenda),
            onTap: () => _navigateTo(context, AgendaPage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(localization.calendar),
            onTap: () => _navigateTo(context, CalendarPage.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.school),
            title: Text(localization.subject),
            onTap: () => _navigateTo(context, SubjectPage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text(localization.timetable),
            onTap: () => _navigateTo(context, TimetablePage.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(localization.settings),
            onTap: () => _navigateTo(context, SettingsPage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text(localization.helpAndFeedBack),
            onTap: () => _navigateTo(context, HelpAndFeedbackPage.routeName),
          ),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, routeName);
  }
}
