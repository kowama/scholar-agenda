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

  TextColumn get description => text().withLength(min: 0, max: 255)();
}

class Timetable extends TimetableDataClass {
  int id;
  String title;
  DateTime start;
  DateTime end;
  String description;

  Timetable({this.id, this.title, this.start, this.end, this.description = ''});

  Timetable.fromDataClass(TimetableDataClass object)
      : id = object.id,
        title = object.title,
        start = object.start,
        end = object.end,
        description = object.description ?? '';
}

@UseDao(tables: [Timetables])
class TimetableDao extends DatabaseAccessor<ScholarAgendaAppDb>
    with _$TimetableDaoMixin {
  final ScholarAgendaAppDb db;

  TimetableDao(this.db) : super(db);

  Future<List<Timetable>> getAllTimetables() async {
    final dataSet = await select(timetables).get();
    return dataSet.map((data) => Timetable.fromDataClass(data)).toList();
  }

  Stream<List<Timetable>> watchAllTimetables() => select(timetables).watch();

  Future insertTimetable(Timetable timetable) =>
      into(timetables).insert(timetable);

  Future updateTimetable(Timetable timetable) =>
      update(timetables).replace(timetable);

  Future deleteTimetable(Timetable timetable) =>
      delete(timetables).delete(timetable);
}
