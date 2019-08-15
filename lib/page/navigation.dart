import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    Key key,
  }) : super(key: key);

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
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          ListTile(
            leading: Icon(Icons.view_agenda),
            title: Text('Agenda'),
            onTap: () => Navigator.pushNamed(context, '/agenda'),
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Calendar'),
            onTap: () => Navigator.pushNamed(context, '/calendar'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Subject'),
            onTap: () => Navigator.pushNamed(context, '/subject'),
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Timetable'),
            onTap: () => Navigator.pushNamed(context, '/timetable'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help and feedback'),
            onTap: () => Navigator.pushNamed(context, '/'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
    );
  }
}
