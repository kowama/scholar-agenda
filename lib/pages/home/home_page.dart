import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:scholar_agenda/localization/localization.dart';

import '../navigation.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";

  final String title = "Home";

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localization = Localization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.overview),
      ),
      drawer: NavigationDrawer(),
      body: _body(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(localization.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _speedDial(),
    );
  }

  Widget _body(int index) {
    final tabs = <Widget>[
      _homeTab(),
      _tabTwo(),
      _tabThree(),
    ];
    return tabs[index];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _homeTab() {
    return Center(child: Text('Tab 1'));
  }

  Widget _tabTwo() {
    return Center(child: Text('Tab 2'));
  }

  Widget _tabThree() {
    return Center(child: Text('Tab 3'));
  }

  Widget _speedDial() {
    final themeData = Theme.of(context);
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      overlayColor: Colors.black,
      overlayOpacity: .5,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            child: Icon(Icons.accessibility, color: themeData.cardColor),
            backgroundColor: Colors.pink,
            label: 'First',
            labelBackgroundColor: themeData.hintColor,
            labelStyle: TextStyle(fontSize: 18.0, color: themeData.cardColor),
            onTap: () => print('FIRST CHILD')),
        SpeedDialChild(
          child: Icon(
            Icons.brush,
            color: themeData.cardColor,
          ),
          backgroundColor: Colors.indigo,
          label: 'Second',
          labelBackgroundColor: themeData.hintColor,
          labelStyle: TextStyle(fontSize: 18.0, color: themeData.cardColor),
          onTap: () => print('SECOND CHILD'),
        ),
        SpeedDialChild(
          child: Icon(Icons.keyboard_voice, color: themeData.cardColor),
          backgroundColor: Colors.teal,
          label: 'Third',
          labelBackgroundColor: themeData.hintColor,
          labelStyle: TextStyle(fontSize: 18.0, color: themeData.cardColor),
          onTap: () => print('THIRD CHILD'),
        ),
      ],
    );
  }
}
