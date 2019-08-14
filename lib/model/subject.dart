import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

const String tableSubject = 'Subject';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnColor = 'color';
const String columnTeacher = 'teacher';
const String columnDescription = 'description';

class Subject {
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
          title == other.title &&
          description == other.description;

  @override
  int get hashCode => title.hashCode ^ teacher.hashCode ^ description.hashCode;

  @override
  String toString() => '{$columnId : $id,'
      ' $columnTitle: $title, '
      '$columnColor: $color, '
      '$columnTeacher: $teacher, '
      '$columnDescription: $description}';
}

class SubjectProvider {
  final Database _database;

  SubjectProvider(this._database) : assert(_database != null);

  static Future createTable(Database db) async {
    assert(db != null);
    await db.execute('''
        create table $tableSubject ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnColor integer not null,
          $columnTeacher text not null,
          $columnDescription integer not null)
        ''');
  }

  Future<Subject> insert(Subject subject) async {
    subject.id = await _database.insert(tableSubject, subject.toMap());
    return subject;
  }

  Future<List<Subject>> getAll() async {
    var subjects = <Subject>[];
    List<Map> maps = await _database.query(tableSubject, columns: [
      columnId,
      columnTitle,
      columnColor,
      columnTeacher,
      columnDescription
    ]);
    maps.forEach((m) => subjects.add(Subject.fromMap(m)));
    return subjects;
  }

  Future<Subject> getSubject(int id) async {
    List<Map> maps = await _database.query(tableSubject,
        columns: [
          columnId,
          columnTitle,
          columnColor,
          columnTeacher,
          columnDescription
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    return maps.isNotEmpty ? Subject.fromMap(maps.first) : null;
  }

  Future<int> delete(int id) async {
    return await _database
        .delete(tableSubject, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Subject subject) async {
    return await _database.update(tableSubject, subject.toMap(),
        where: '$columnId = ?', whereArgs: [subject.id]);
  }
}
