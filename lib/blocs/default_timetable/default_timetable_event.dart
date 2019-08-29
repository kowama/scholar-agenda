import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class DefaultTimetableEvent extends Equatable {
  DefaultTimetableEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadDefaultTimetable extends DefaultTimetableEvent {
  @override
  String toString() {
    return 'LoadDefaultTimetable{}';
  }
}

class UpdateDefaultTimetable extends DefaultTimetableEvent {
  final Timetable timetable;

  UpdateDefaultTimetable(this.timetable) : super([timetable]);

  @override
  String toString() {
    return 'UpdateDefaultTimetable{timetable: $timetable}';
  }
}
