import 'package:moor_flutter/moor_flutter.dart';
import 'package:scholar_agenda/models/event.dart';

import 'period.dart';
import 'subject.dart';
import 'timetable.dart';

part 'database.g.dart';

const AppDbName = 'scholar_agenda_db.sqlite';

@UseMoor(
    tables: [Periods, Timetables, Subjects, Events],
    daos: [PeriodDao, TimetableDao, SubjectDao, EventDao])
class ScholarAgendaAppDb extends _$ScholarAgendaAppDb {
  ScholarAgendaAppDb()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: AppDbName,
          logStatements: true,
        ));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    // Runs after all the migrations but BEFORE any queries have a chance to execute
  beforeOpen: (db, details) async {
  await db.customStatement('PRAGMA foreign_keys = ON');
},
);
}
