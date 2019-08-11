import 'package:flutter/material.dart';

import '../navigation.dart';

const String HOME_PAGE_ROUTE = "/";

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  final String title = "Home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              'Home',
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
