import 'package:sqflite/sqlite_api.dart';

import 'abstract.dart';

class Timetable {
  static const String tableName = 'Timetable';
  static const String columnId = '_id';
  static const String columnTitle = 'title';
  static const String columnStart = 'start';
  static const String columnEnd = 'end';
  static const String columnDescription = 'description';

  int id;
  String title;
  DateTime start;
  DateTime end;
  String description;

  Timetable({this.id, this.title, this.start, this.end, this.description});

  Timetable.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        title = map[columnTitle],
        start = DateTime.parse(map[columnStart]),
        end = DateTime.parse(map[columnEnd]),
        description = map[columnDescription];

  Map<String, dynamic> toMap() => {
        columnId: id,
        columnTitle: title,
        columnStart: start.toIso8601String(),
        columnEnd: end.toIso8601String(),
        columnDescription: description,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Timetable &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          start == other.start &&
          end == other.end &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      start.hashCode ^
      end.hashCode ^
      description.hashCode;

  @override
  String toString() => '{$columnId : $id,'
      ' $columnTitle: $title, '
      '$columnStart: $start, '
      '$columnEnd: $end, '
      '$columnDescription: $description}';
}

class TimetableProvider extends Provider<Timetable> {
  TimetableProvider(Database database)
      : super(database, TimetableProviderConfig());
}

class TimetableProviderConfig extends ProviderConfig<Timetable> {
  @override
  String get columnId => Timetable.columnId;

  @override
  List<String> get columns => [
        Timetable.columnId,
        Timetable.columnTitle,
        Timetable.columnStart,
        Timetable.columnEnd,
        Timetable.columnDescription,
      ];

  @override
  String get createTableSql => '''
        CREATE TABLE  ${Timetable.tableName} ( 
          ${Timetable.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, 
          ${Timetable.columnTitle} TEXT NOT NULL,
          ${Timetable.columnStart} TEXT NOT NULL,
          ${Timetable.columnEnd} TEXT NOT NULL,
          ${Timetable.columnDescription} TEXT NOT NULL);
        ''';

  @override
  Timetable fromMap(Map<String, dynamic> map, {Database database}) {
    return Timetable.fromMap(map);
  }

  @override
  int getIdOf(Timetable entity) {
    return entity.id;
  }

  @override
  void setIdOf(Timetable entity, int value) {}

  @override
  String get tableName => Timetable.tableName;

  @override
  Map<String, dynamic> toMap(Timetable entity) {
    return entity.toMap();
  }
}
