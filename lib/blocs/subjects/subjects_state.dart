import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class SubjectsState extends Equatable {
  SubjectsState([List props = const <dynamic>[]]) : super(props);
}

class SubjectsLoading extends SubjectsState {
  @override
  String toString() {
    return 'SubjectsLoading{}';
  }
}

class SubjectsLoaded extends SubjectsState {
  final List<Subject> subjects;

  SubjectsLoaded(this.subjects) : super([subjects]);

  @override
  String toString() {
    return 'SubjectsLoaded{subjects: $subjects}';
  }
}

class ErrorSubjectsNotLoaded extends SubjectsState {
  final Exception exception;

  ErrorSubjectsNotLoaded(this.exception);

  @override
  String toString() {
    return 'ErrorSubjectsNotLoaded{exception: $exception}';
  }
}
