import 'package:sqflite/sqlite_api.dart';

import 'abstract.dart';
import 'timetable.dart';
import 'subject.dart';

class Period {
  static const String tableName = 'Period';
  static const String columnId = '_id';
  static const String columnStart = 'start';
  static const String columnEnd = 'end';
  static const String columnLocation = 'location';
  static const String columnTimetable = 'timetable';
  static const String columnSubject = 'subject';

  int id;
  DateTime start;
  DateTime end;
  String location;
  Timetable timetable;
  Subject subject;

  Period(
      {this.id,
      this.start,
      this.end,
      this.location,
      this.timetable,
      this.subject});

  Period.fromMap(Map<String, dynamic> map, Database database)
      :assert(database!= null), id = map[columnId],
        start = DateTime.parse(map[columnStart]),
        end = DateTime.parse(map[columnEnd]),
        location = map[columnLocation],
        timetable = getTimeTable(map[columnTimetable], database),
        subject = getSubject(map[columnSubject], database);

  Map<String, dynamic> toMap() => {
        columnId: id,
        columnStart: start.toIso8601String(),
        columnEnd: end.toIso8601String(),
        columnLocation: location,
        columnTimetable: timetable.id,
        columnSubject: subject.id,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Period &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          start == other.start &&
          end == other.end &&
          location == other.location &&
          timetable == other.timetable &&
          subject == other.subject;

  @override
  int get hashCode =>
      id.hashCode ^
      start.hashCode ^
      end.hashCode ^
      location.hashCode ^
      timetable.hashCode ^
      subject.hashCode;

  @override
  String toString() => '{$columnId : $id,'
      '$columnStart: $start, '
      '$columnEnd: $end, '
      '$columnLocation: $location, '
      '$columnTimetable: $timetable, '
      '$columnSubject: $subject}';

  static getTimeTable(int id, Database database) {}

  static getSubject(int id, Database database) {}
}

class PeriodProvider extends Provider<Period> {
  PeriodProvider(Database database) : super(database, PeriodProviderConfig());
}

class PeriodProviderConfig extends ProviderConfig<Period> {
  @override
  String get columnId => Period.columnId;

  @override
  List<String> get columns => [
        Period.columnId,
        Period.columnStart,
        Period.columnStart,
        Period.columnLocation,
        Period.columnTimetable,
        Period.columnSubject,
      ];

  @override
  String get createTableSql => '''
        create table ${Period.tableName} ( 
          ${Period.columnId} integer primary key autoincrement, 
          ${Period.columnStart} text not null,
          ${Period.columnEnd} text not null,
          ${Period.columnLocation} text not null,
          ${Period.columnTimetable} integer not null,
          ${Period.columnSubject} integer not null,
        ''';

  @override
  Period fromMap(Map<String, dynamic> map, {Database database}) {
    return Period.fromMap(map, database);
  }

  @override
  int getIdOf(Period entity) {
    return entity.id;
  }

  @override
  void setIdOf(Period entity, int value) {
    entity.id = value;
  }

  @override
  String get tableName => Period.tableName;

  @override
  Map<String, dynamic> toMap(Period entity) {
    return entity.toMap();
  }
}
