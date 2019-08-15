import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'abstract.dart';

class Subject {
  static const String tableName = 'Subject';
  static const String columnId = '_id';
  static const String columnTitle = 'title';
  static const String columnColor = 'color';
  static const String columnTeacher = 'teacher';
  static const String columnDescription = 'description';

  int id;
  String title;
  Color color;
  String teacher;
  String description;

  Subject({this.title, this.color, this.teacher, this.description});

  Subject.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        title = map[columnTitle],
        color = Color(map[columnColor]),
        teacher = map[columnTeacher],
        description = map[columnDescription];

  Map<String, dynamic> toMap() => {
        columnId: id,
        columnTitle: title,
        columnColor: color.value,
        columnTeacher: teacher,
        columnDescription: description,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Subject &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          color == other.color &&
          teacher == other.teacher &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      color.hashCode ^
      teacher.hashCode ^
      description.hashCode;

  @override
  String toString() => '{$columnId : $id,'
      ' $columnTitle: $title, '
      '$columnColor: $color, '
      '$columnTeacher: $teacher, '
      '$columnDescription: $description}';
}

class SubjectProvider extends Provider<Subject> {
  SubjectProvider(Database database) : super(database, SubjectProviderConfig());
}

class SubjectProviderConfig extends ProviderConfig<Subject> {
  @override
  String get tableName => Subject.tableName;

  @override
  String get createTableSql => '''
        create table ${Subject.tableName} ( 
          ${Subject.columnId} integer primary key autoincrement, 
          ${Subject.columnTitle} text not null,
          ${Subject.columnColor} integer not null,
          ${Subject.columnTeacher} text not null,
          ${Subject.columnDescription} integer not null)
        ''';

  @override
  String get columnId => Subject.columnId;

  @override
  List<String> get columns => [
        Subject.columnId,
        Subject.columnTitle,
        Subject.columnColor,
        Subject.columnTeacher,
        Subject.columnDescription
      ];

  @override
  Subject fromMap(Map<String, dynamic> map,{Database database}) {
    return Subject.fromMap(map);
  }

  @override
  getIdOf(Subject subject) {
    return subject.id;
  }

  @override
  void setIdOf(Subject subject, int value) {
    subject.id = value;
  }

  @override
  Map<String, dynamic> toMap(Subject subject) {
    return subject.toMap();
  }
}
