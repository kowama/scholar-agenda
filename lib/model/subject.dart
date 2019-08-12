import 'package:flutter/material.dart';

class Subject {
  final String id;
  String title;
  Color color;
  String teacher;
  String description;

  Subject({this.id, this.title, this.color, this.description});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Subject &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}
