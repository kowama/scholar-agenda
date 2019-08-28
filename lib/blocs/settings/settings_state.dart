import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
  SettingsLoaded() : super();

  @override
  String toString() {
    return 'SettingsLoaded{}';
  }
}

class ErrorSettingsNotLoaded extends SettingsState {
  final Exception exception;

  ErrorSettingsNotLoaded(this.exception);

  @override
  String toString() {
    return 'ErrorDefaultTimetableNotLoaded{}';
  }
}
