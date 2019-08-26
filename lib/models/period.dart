import 'package:moor_flutter/moor_flutter.dart';

import 'database.dart';

part 'period.g.dart';

@DataClassName('PeriodDataClass')
class Periods extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dayOfWeek => integer()();

  DateTimeColumn get start => dateTime()();

  DateTimeColumn get end => dateTime()();

  TextColumn get location => text().nullable().withLength(min: 0, max: 50)();

//  Timetable timetable;
//  Subject subject;

}

@UseDao(tables: [Periods])
class PeriodDao extends DatabaseAccessor<ScholarAgendaAppDb>
    with _$PeriodDaoMixin {
  final ScholarAgendaAppDb db;

  PeriodDao(this.db) : super(db);
}
