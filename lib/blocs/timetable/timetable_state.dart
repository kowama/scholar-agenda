import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class TimetableState extends Equatable {
  TimetableState([List props = const <dynamic>[]]) : super(props);
}

class TimetablesLoading extends TimetableState {
  @override
  String toString() => 'TimetablesLoading';
}

class TimetablesLoaded extends TimetableState {
  final List<Timetable> timetables;

  TimetablesLoaded(this.timetables) : super([timetables]);

  @override
  String toString() => 'TimetablesLoaded { timetables : $timetables }';
}

class ErrorTimetablesNotLoaded extends TimetableState {
  final error;

  ErrorTimetablesNotLoaded(this.error) : super([error]);

  @override
  String toString() => 'ErrorTimetablesNotLoaded{ error $error }';
}
