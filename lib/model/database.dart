import 'package:moor_flutter/moor_flutter.dart';
import 'package:scholar_agenda/model/subject.dart';

import 'period.dart';
import 'timetable.dart';

part 'database.g.dart';

const AppDbName = 'scholar_agenda_db.sqlite';

@UseMoor(
    tables: [Periods, Timetables, Subjects],
    daos: [PeriodDao, TimetableDao, SubjectDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
          path: AppDbName,
          logStatements: true,
        ));

  @override
  int get schemaVersion => 1;
}
