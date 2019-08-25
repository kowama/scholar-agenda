import 'package:moor_flutter/moor_flutter.dart';

import 'database.dart';

part 'subject.g.dart';

class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 50)();

  IntColumn get color => integer()();

  TextColumn get teacher => text().withLength(min: 1, max: 50)();

  TextColumn get description => text().withLength(min: 1, max: 255)();
}

@UseDao(tables: [Subjects])
class SubjectDao extends DatabaseAccessor<AppDatabase> with _$SubjectDaoMixin {
  final AppDatabase db;

  SubjectDao(this.db) : super(db);

}
