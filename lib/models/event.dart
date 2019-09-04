import 'package:moor_flutter/moor_flutter.dart';

import 'database.dart';
import 'subject.dart';

part 'event.g.dart';

/// generate db after editing the code
/// cmd :: flutter pub run build_runner build watch

@DataClassName('EventDataClass')
class Events extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text().withLength(min: 1, max: 50)();

  /// enum of event type
  IntColumn get typeValue => integer()();

  DateTimeColumn get date => dateTime()();

  DateTimeColumn get remindMeAt => dateTime().nullable()();

  /// time
  DateTimeColumn get start => dateTime().nullable()();

  /// time
  DateTimeColumn get end => dateTime().nullable()();

  /// enum of repeat mode
  IntColumn get repeatModeValue => integer()();

  TextColumn get note => text().withLength(min: 0, max: 128)();

  IntColumn get subjectId =>
      integer().customConstraint('REFERENCES subjects(id)').nullable()();
}

class Event extends EventDataClass {
  int id;
  String title;
  DateTime date;
  DateTime start;
  DateTime end;
  DateTime remindMeAt;
  int repeatModeValue;
  int typeValue;
  String note;
  int subjectId;
  Subject _subject;

  Event({
    this.id,
    this.title,
    this.date,
    this.start,
    this.end,
    this.remindMeAt,
    EventRepeatMode repeatMode,
    EventType type,
    this.note,
    Subject subject,
  })  : repeatModeValue = repeatMode?.value,
        typeValue = type?.value {
    _subject = subject;
    subjectId = _subject?.id;
  }

  Event.fromDataClass(EventDataClass object, {Subject subject})
      : id = object.id,
        title = object.title,
        date = object.date,
        start = object.start,
        end = object.end,
        remindMeAt = object.remindMeAt,
        repeatModeValue = object.repeatModeValue {
    _subject = subject;
    subjectId = _subject?.id;
  }

  EventRepeatMode get repeatMode => EventRepeatMode(repeatModeValue);

  set repeatMode(EventRepeatMode mode) {
    repeatModeValue = mode.value;
  }

  EventType get type => EventType(typeValue);

  set(EventType type) {
    typeValue = type.value;
  }

  Subject get subject => _subject;

  set subject(Subject s) {
    _subject = s;
    subjectId = _subject?.id;
  }

  @override
  String toString() {
    return 'Event{id: $id,'
        ' title: $title,'
        ' date: $date,'
        ' start: $start,'
        ' end: $end,'
        ' remindMeAt: $remindMeAt,'
        ' repeatModeValue: $repeatModeValue,'
        ' typeValue: $typeValue,'
        ' note: $note,'
        ' subjectId: $subjectId,'
        ' _subject: $_subject}';
  }
}

@UseDao(
  tables: [Events, Subjects],
)
class EventDao extends DatabaseAccessor<ScholarAgendaAppDb>
    with _$EventDaoMixin {
  final ScholarAgendaAppDb db;

  EventDao(this.db) : super(db);

  Future<List<Event>> getAllEvents() async {
    final querySet = await select(events).join([
      innerJoin(subjects, subjects.id.equalsExp(events.subjectId)),
    ]).get();
    return querySet
        .map((row) => Event.fromDataClass(
              row.readTable(events),
              subject: Subject.fromDataClass(row.readTable(subjects)),
            ))
        .toList();
  }

  Future<List<Event>> findBySubject(Subject s) async {
    final querySet =
        await (select(events)..where((e) => e.subjectId.equals(s.id))).join([
      innerJoin(subjects, subjects.id.equalsExp(events.subjectId))
    ]).get();
    return querySet
        .map((row) => Event.fromDataClass(
              row.readTable(events),
              subject: Subject.fromDataClass(row.readTable(subjects)),
            ))
        .toList();
  }

  Future<int> insertEvent(Event event) => into(events).insert(event);

  Future<bool> updateEvent(Event event) => update(events).replace(event);

  Future<int> deleteEvent(Event event) => delete(events).delete(event);
}

class EventRepeatMode {
  static const EventRepeatMode noRepeat = EventRepeatMode._internal(0);
  static const EventRepeatMode week = EventRepeatMode._internal(1);
  static const EventRepeatMode twoWeek = EventRepeatMode._internal(2);
  static const EventRepeatMode month = EventRepeatMode._internal(3);

  final int value;

  const EventRepeatMode._internal(this.value)
      : assert(value >= 0 && value <= 3);

  factory EventRepeatMode(int value) {
    assert(value >= 0 && value <= 3);
    if (value == 0) return noRepeat;
    if (value == 1) return week;
    if (value == 2) return twoWeek;
    return month;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventRepeatMode &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'EventRepeatMode{value: $value}';
  }
}

class EventType {
  static const EventType homework = EventType._internal(0);
  static const EventType exam = EventType._internal(1);
  static const EventType reminder = EventType._internal(2);

  final int value;

  const EventType._internal(this.value) : assert(value >= 0 && value <= 2);

  factory EventType(int value) {
    assert(value >= 0 && value <= 2);
    if (value == 0) return homework;
    if (value == 1) return exam;
    return reminder;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventType &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return 'EventType{value: $value}';
  }
}
