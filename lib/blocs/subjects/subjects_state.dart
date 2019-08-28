import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class SubjectState extends Equatable {
  SubjectState([List props = const <dynamic>[]]) : super(props);
}

class SubjectsLoading extends SubjectState {
  @override
  String toString() {
    return 'SubjectsLoading{}';
  }
}

class SubjectsLoaded extends SubjectState {
  final List<Subject> subjects;

  SubjectsLoaded(this.subjects) : super([subjects]);

  @override
  String toString() {
    return 'SubjectsLoaded{subjects: $subjects}';
  }
}

class ErrorSubjectsNotLoaded extends SubjectState {
  final Exception exception;

  ErrorSubjectsNotLoaded(this.exception);

  @override
  String toString() {
    return 'ErrorSubjectsNotLoaded{exception: $exception}';
  }
}
