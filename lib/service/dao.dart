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

  factory DbService() {
    return _dbService;
  }

  DbService._internal() {
    _initialize();
  }

  SubjectProvider get subject => _subjectProvider;

  PeriodProvider get period => _periodProvider;

  TimetableProvider get timetable => _timetableProvider;

  Future _initialize() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, DB_NAME);
    var database = await openDatabase(path, version: 1,
        onCreate: (Database database, int version) async {
      _subjectProvider = SubjectProvider(database);
      _periodProvider = PeriodProvider(database);
      _timetableProvider = TimetableProvider(database);
      await _subjectProvider.createTable();
      await _timetableProvider.createTable();
      await _periodProvider.createTable();
    });
    _subjectProvider = SubjectProvider(database);
    _periodProvider = PeriodProvider(database);
    _timetableProvider = TimetableProvider(database);
    _database = database;
  }

  Future close() async => _database.close();
}
