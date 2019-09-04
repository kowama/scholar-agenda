import 'package:flutter/widgets.dart';

class Choice {
  const Choice({this.title, this.icon, this.onSelected});

  final String title;
  final IconData icon;
  final VoidCallback onSelected;
}
