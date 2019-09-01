import 'package:moor_flutter/moor_flutter.dart';

import 'database.dart';
import 'subject.dart';
import 'timetable.dart';

part 'period.g.dart';

@DataClassName('PeriodDataClass')
class Periods extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get dayOfWeek => integer()();

  DateTimeColumn get start => dateTime()();

  DateTimeColumn get end => dateTime()();

  TextColumn get location => text().withLength(min: 0, max: 50)();

  IntColumn get timetableId =>
      integer().customConstraint('REFERENCES timetables(id)')();

  IntColumn get subjectId =>
      integer().customConstraint('REFERENCES subjects(id)')();
}

class Period extends PeriodDataClass {
  int id;
  int dayOfWeek;
  DateTime start;
  DateTime end;
  String location;
  int timetableId;
  Timetable _timetable;
  int subjectId;
  Subject _subject;

  Period(
      {this.id,
      this.dayOfWeek,
      this.start,
      this.end,
      this.location = '',
      Timetable timetable,
      Subject subject})
      : _timetable = timetable,
        _subject = subject,
        timetableId = timetable?.id,
        subjectId = subject?.id;

  Period.fromDataClass(PeriodDataClass object,
      {Timetable timetable, Subject subject})
      : id = object.id,
        dayOfWeek = object.dayOfWeek,
        start = object.start,
        end = object.end,
        location = object.location ?? '',
        subjectId = object.subjectId,
        _subject = subject,
        timetableId = object.timetableId,
        _timetable = timetable;

  Timetable get timetable => _timetable;

  set timetable(Timetable value) {
    assert(value != null);
    _timetable = value;
    timetableId = _timetable.id;
  }

  Subject get subject => _subject;

  set subject(Subject value) {
    assert(value != null);
    _subject = value;
    subjectId = _subject.id;
  }

  @override
  String toString() {
    return 'Period{id: $id,'
        ' dayOfWeek: $dayOfWeek, '
        'start: $start,'
        ' end: $end,'
        ' location: $location, '
        'timetableId: $timetableId,'
        ' timetable: $_timetable,'
        ' subjectId: $subjectId, '
        'subject: $_subject}';
  }
}

@UseDao(
  tables: [Periods, Timetables, Subjects],
)
class PeriodDao extends DatabaseAccessor<ScholarAgendaAppDb>
    with _$PeriodDaoMixin {
  final ScholarAgendaAppDb db;

  PeriodDao(this.db) : super(db);

  Future<List<Period>> getAllPeriods() async {
    final querySet = await select(periods).join([
      innerJoin(timetables, timetables.id.equalsExp(periods.timetableId)),
      innerJoin(subjects, subjects.id.equalsExp(periods.subjectId)),
    ]).get();
    return querySet
        .map((row) => Period.fromDataClass(
              row.readTable(periods),
              timetable: Timetable.fromDataClass(row.readTable(timetables)),
              subject: Subject.fromDataClass(row.readTable(subjects)),
            ))
        .toList();
  }

  Future<List<Period>> getAllWithTimetable(Timetable t) async {
    final querySet =
        await (select(periods)..where((p) => p.timetableId.equals(t.id))).join([
      innerJoin(subjects, subjects.id.equalsExp(periods.subjectId))
    ]).get();

    return querySet
        .map((row) => Period.fromDataClass(
              row.readTable(periods),
              timetable: t,
              subject: Subject.fromDataClass(row.readTable(subjects)),
            ))
        .toList();
  }

  Future<int> insertPeriod(Period period) => into(periods).insert(period);

  Future<bool> updatePeriod(Period period) => update(periods).replace(period);

  Future<int> deletePeriod(Period period) => delete(periods).delete(period);
}
