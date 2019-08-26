import 'package:moor_flutter/moor_flutter.dart';
import 'package:scholar_agenda/models/models.dart';

import 'database.dart';

part 'timetable.g.dart';

@DataClassName('TimetableDataClass')
class Timetables extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 50)();

  DateTimeColumn get start => dateTime()();

  DateTimeColumn get end => dateTime()();

  TextColumn get description =>
      text().nullable().withLength(min: 0, max: 255)();
}

@UseDao(tables: [Timetables])
class TimetableDao extends DatabaseAccessor<ScholarAgendaAppDb>
    with _$TimetableDaoMixin {
  final ScholarAgendaAppDb db;

  TimetableDao(this.db) : super(db);
}
