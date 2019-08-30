import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class TimetablePeriodsEvent extends Equatable {
  TimetablePeriodsEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadTimetablePeriods extends TimetablePeriodsEvent {
  final Timetable timetable;

  LoadTimetablePeriods(this.timetable) : super([timetable]);

  @override
  String toString() {
    return 'LoadTimetablePeriods{timetable: $timetable}';
  }
}

class AddPeriod extends TimetablePeriodsEvent {
  final Period period;

  AddPeriod(this.period);

  @override
  String toString() {
    return 'AddPeriod{period: $period}';
  }
}

class UpdatePeriod extends TimetablePeriodsEvent {
  final Period period;

  UpdatePeriod(this.period);

  @override
  String toString() {
    return 'UpdatePeriod{period: $period}';
  }
}

class DeletePeriod extends TimetablePeriodsEvent {
  final Period period;

  DeletePeriod(this.period);

  @override
  String toString() {
    return 'DeletePeriod{period: $period}';
  }
}
