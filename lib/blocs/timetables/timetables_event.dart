import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class TimetableEvent extends Equatable {
  TimetableEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadTimetables extends TimetableEvent {
  @override
  String toString() {
    return 'LoadTimetables{}';
  }
}

class AddTimetable extends TimetableEvent {
  final Timetable timetable;

  AddTimetable(this.timetable) : super([timetable]);

  @override
  String toString() {
    return 'AddTimetable{timetable: $timetable}';
  }
}

class UpdateTimetable extends TimetableEvent {
  final Timetable timetable;

  UpdateTimetable(this.timetable) : super([timetable]);

  @override
  String toString() {
    return 'UpdateTimetable{timetable: $timetable}';
  }
}

class DeleteTimetable extends TimetableEvent {
  final Timetable timetable;

  DeleteTimetable(this.timetable) : super([timetable]);

  @override
  String toString() {
    return 'DeleteTimetable{timetable: $timetable}';
  }
}
