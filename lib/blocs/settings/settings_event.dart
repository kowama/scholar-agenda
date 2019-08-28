import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  SettingsEvent([List props = const []]) : super(props);
}

class LoadSettings extends SettingsEvent {
  @override
  String toString() {
    return 'LoadDefaultSettings{}';
  }
}

class UpdateDefaultTimetable extends SettingsEvent {
  final Timetable timetable;

  UpdateDefaultTimetable(this.timetable) : super([timetable]);

  @override
  String toString() {
    return 'UpdateDefaultTimetable{timetable: $timetable}';
  }
}
