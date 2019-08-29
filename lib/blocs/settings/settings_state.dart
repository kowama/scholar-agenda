import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class SettingsState extends Equatable {
  SettingsState([List props = const []]) : super(props);
}

class SettingLoading extends SettingsState {
  @override
  String toString() {
    return 'DefaultTimetableLoading{}';
  }
}

class SettingsLoaded extends SettingsState {
  final Timetable defaultTimetable;

  SettingsLoaded(this.defaultTimetable) : super([defaultTimetable]);
}

class ErrorSettingsNotLoaded extends SettingsState {
  final Exception exception;

  ErrorSettingsNotLoaded(this.exception);

  @override
  String toString() {
    return 'ErrorDefaultTimetableNotLoaded{}';
  }
}
