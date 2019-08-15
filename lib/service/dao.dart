import 'package:path/path.dart';
import 'package:scholar_agenda/model/period.dart';
import 'package:scholar_agenda/model/subject.dart';
import 'package:scholar_agenda/model/timetable.dart';
import 'package:sqflite/sqflite.dart';

const DB_NAME = 'scholar_agenda.db';

//follow singleton pattern
class DbService {
  static final DbService _dbService = DbService._internal();
  Database _database;
  SubjectProvider _subjectProvider;
  PeriodProvider _periodProvider;
  TimetableProvider _timetableProvider;
  bool initialized = false;

  factory DbService() {
    return _dbService;
  }

  DbService._internal();

  SubjectProvider get subject => _subjectProvider;

  PeriodProvider get period => _periodProvider;

  TimetableProvider get provider => _timetableProvider;

  Future initialize() async {
    if (initialized) return;

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, DB_NAME);
    var database = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      _subjectProvider = SubjectProvider(database);
      _periodProvider = PeriodProvider(database);
      _timetableProvider = TimetableProvider(database);
      await _subjectProvider.createTable();
    });
    _subjectProvider = SubjectProvider(database);
    _periodProvider = PeriodProvider(database);
    _timetableProvider = TimetableProvider(database);
    _database = database;
    initialized = true;
  }

  Future close() async => _database.close();
}
