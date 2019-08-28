import 'package:moor_flutter/moor_flutter.dart';

import 'dart:ui';
import 'database.dart';

part 'subject.g.dart';

@DataClassName('SubjectDataClass')
class Subjects extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 50)();

  IntColumn get colorValue => integer()();

  TextColumn get teacher => text().withLength(min: 0, max: 50)();

  TextColumn get description =>
      text().nullable().withLength(min: 0, max: 255)();
}

class Subject extends SubjectDataClass {
  int id;
  String title;
  int colorValue;
  Color _color;
  String teacher;
  String description;

  Subject({this.id, this.title, Color color, this.description, this.teacher}) {
    _color = color;
    colorValue = _color?.value;
  }

  Subject.fromDataClass(SubjectDataClass object)
      : id = object.id,
        title = object.title,
        colorValue = object.colorValue,
        _color = Color(object.colorValue),
        teacher = object.teacher,
        description = object.description;

  Color get color => _color;

  set color(Color value) {
    _color = value;
    colorValue = value.value;
  }
}

@UseDao(tables: [Subjects])
class SubjectDao extends DatabaseAccessor<ScholarAgendaAppDb>
    with _$SubjectDaoMixin {
  final ScholarAgendaAppDb db;

  SubjectDao(this.db) : super(db);

  Future<List<Subject>> getAllSubjects() async {
    final subjectsList = await select(subjects).get();
    return subjectsList
        .map((subject) => Subject.fromDataClass(subject))
        .toList();
  }

  Stream<List<Subject>> watchAllSubjects() => select(subjects).watch();

  Future insertSubject(Subject subject) => into(subjects).insert(subject);

  Future updateSubject(Subject subject) => update(subjects).replace(subject);

  Future deleteSubject(Subject subject) => delete(subjects).delete(subject);
}
