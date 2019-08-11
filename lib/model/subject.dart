import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Subject {
  final String id;
  String title;
  Color color;
  String description;

  Subject(
      {@required this.id,
      @required this.title,
      @required this.color,
      this.description});

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
