import 'package:moor_flutter/moor_flutter.dart';

import 'database.dart';


part 'period.g.dart';

class Periods extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dayOfWeek => integer().customConstraint("field in (1, 7")();

  DateTimeColumn get start => dateTime().nullable()();

  DateTimeColumn get end => dateTime().nullable()();

  TextColumn get location => text().withLength(min: 1, max: 50).nullable()();

//  Timetable timetable;
//  Subject subject;

}

@UseDao(tables: [Periods])
class PeriodDao extends DatabaseAccessor<AppDatabase> with _$PeriodDaoMixin {
  final AppDatabase db;

  PeriodDao(this.db) : super(db);

}
