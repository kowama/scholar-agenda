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
    return 'LoadSettings{}';
  }
}

class UpdateSettings extends SettingsEvent {
  final Timetable timetable;

  UpdateSettings({@required this.timetable}) : super([timetable]);

  UpdateSettings copyWith({Timetable timetable}) => UpdateSettings(
        timetable: timetable ?? this.timetable,
      );

  @override
  String toString() {
    return 'UpdateSettings{timetable: $timetable}';
  }
}
