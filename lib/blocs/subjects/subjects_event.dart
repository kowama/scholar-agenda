import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class SubjectsEvent extends Equatable {
  SubjectsEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadSubjects extends SubjectsEvent {

  @override
  String toString() {
    return 'LoadSubjects{}';
  }
}

class AddSubject extends SubjectsEvent {
  final Subject subject;

  AddSubject(this.subject) : super([subject]);

  @override
  String toString() {
    return 'AddSubject{subject: $subject}';
  }
}

class UpdateSubject extends SubjectsEvent {
  final Subject subject;

  UpdateSubject(this.subject) : super([subject]);

  @override
  String toString() {
    return 'UpdateSubject{subject: $subject}';
  }
}

class DeleteSubject extends SubjectsEvent {
  final Subject subject;

  DeleteSubject(this.subject) : super([subject]);

  @override
  String toString() {
    return 'DeleteSubject{subject: $subject}';
  }
}
