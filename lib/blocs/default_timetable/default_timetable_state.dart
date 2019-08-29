import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/timetable.dart';

@immutable
abstract class DefaultTimetableState extends Equatable {
  DefaultTimetableState([List props = const <dynamic>[]]) : super(props);
}

class DefaultTimetableLoading extends DefaultTimetableState {
  @override
  String toString() {
    return 'DefaultTimetableLoading{}';
  }
}

class DefaultTimetableNotSet extends DefaultTimetableState {
  @override
  String toString() {
    return 'DefaultTimetableNotSet{}';
  }
}

class DefaultTimetableLoaded extends DefaultTimetableState {
  final Timetable timetable;

  DefaultTimetableLoaded(this.timetable) : super([timetable]);

  @override
  String toString() {
    return 'DefaultTimetableLoaded{timetable: $timetable}';
  }
}