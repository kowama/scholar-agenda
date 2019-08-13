import 'package:path/path.dart';
import 'package:scholar_agenda/model/subject.dart';
import 'package:sqflite/sqflite.dart';

const DB_NAME = 'scholar_agenda.db';

//follow singleton pattern
class DbService {
  static final DbService _dbService = DbService._internal();
  Database _database;
  SubjectProvider _subjectProvider;
  bool initialized = false;

  factory DbService() {
    return _dbService;
  }

  DbService._internal();

  SubjectProvider get subject => _subjectProvider;

  Future initialize() async {
    if (initialized) return;

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, DB_NAME);
    var db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await SubjectProvider.createTable(db);
    });
    _subjectProvider = SubjectProvider(db);
    print('init database : $db');
    _database = db;

    initialized = true;
  }

  Future close() async => _database.close();
}
