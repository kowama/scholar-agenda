import 'package:moor_flutter/moor_flutter.dart';
import 'package:scholar_agenda/model/database.dart';

part 'timetable.g.dart';

class Timetables extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 50)();

  DateTimeColumn get start => dateTime()();

  DateTimeColumn get end => dateTime()();

  TextColumn get description =>
      text().withLength(min: 1, max: 255).nullable()();
}

@UseDao(tables: [Timetables])
class TimetableDao extends DatabaseAccessor<AppDatabase>
    with _$TimetableDaoMixin {
  final AppDatabase db;

  TimetableDao(this.db) : super(db);
}
