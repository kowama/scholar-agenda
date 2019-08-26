import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class SubjectState extends Equatable {
  SubjectState([List props = const <dynamic>[]]) : super(props);
}

class LoadingSubjectsState extends SubjectState {
  @override
  String toString() => 'SubjectsLoading';
}

class LoadedSubjectsState extends SubjectState {
  final List<Subject> subjects;

  LoadedSubjectsState([this.subjects = const []]) : super([subjects]);

  @override
  String toString() => 'SubjectsLoaded { subjects: $subjects }';
}

class NotLoadedSubjectsState extends SubjectState {
  final error;

  NotLoadedSubjectsState(this.error);

  @override
  String toString() => 'SubjectsNotLoaded';
}
