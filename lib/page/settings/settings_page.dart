import 'package:flutter/material.dart';
import '../navigation.dart';

const String SETTINGS_PAGE_ROUTE = "/settings";

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);
  final String title = "Settings";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  _action() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: new NavigationDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Settings',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _action(),
        tooltip: 'Action',
        child: Icon(Icons.add),
      ),
    );
  }
}
