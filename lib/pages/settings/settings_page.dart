import 'package:flutter/material.dart';
import '../navigation.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = "/settings";
  final String title = "Settings";

  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    );
  }
}
