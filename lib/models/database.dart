import 'package:moor_flutter/moor_flutter.dart';

import 'period.dart';
import 'subject.dart';
import 'timetable.dart';

part 'database.g.dart';

const AppDbName = 'scholar_agenda_db.sqlite';

@UseMoor(
    tables: [Periods, Timetables, Subjects],
    daos: [PeriodDao, TimetableDao, SubjectDao])
class ScholarAgendaAppDb extends _$ScholarAgendaAppDb {
  ScholarAgendaAppDb()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: AppDbName,
          logStatements: true,
        ));

  @override
  int get schemaVersion => 1;
}
