import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class TimetablePeriodsState extends Equatable {
  TimetablePeriodsState([List props = const <dynamic>[]]) : super(props);
}

class TimetableNotSet extends TimetablePeriodsState {
  @override
  String toString() {
    return 'TimetableNotSet{}';
  }
}

class TimetablePeriodsLoading extends TimetablePeriodsState {
  final Timetable timetable;

  TimetablePeriodsLoading(this.timetable)
      : assert(timetable != null),
        super([timetable]);

  @override
  String toString() {
    return 'TimetablePeriodsLoading{timetable: $timetable}';
  }
}

class TimetablePeriodsLoaded extends TimetablePeriodsState {
  final Timetable timetable;
  final List<Period> periods;

  TimetablePeriodsLoaded(this.timetable, this.periods)
      : super([timetable, periods]);

  @override
  String toString() {
    return 'TimetablePeriodsLoaded{timetable: $timetable, periods: $periods}';
  }
}
