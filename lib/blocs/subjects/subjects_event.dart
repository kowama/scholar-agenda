import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class SubjectEvent extends Equatable {
  SubjectEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadSubjects extends SubjectEvent {

  @override
  String toString() {
    return 'LoadSubjects{}';
  }
}

class AddSubject extends SubjectEvent {
  final Subject subject;

  AddSubject(this.subject) : super([subject]);

  @override
  String toString() {
    return 'AddSubject{subject: $subject}';
  }
}

class UpdateSubject extends SubjectEvent {
  final Subject subject;

  UpdateSubject(this.subject) : super([subject]);

  @override
  String toString() {
    return 'UpdateSubject{subject: $subject}';
  }
}

class DeleteSubject extends SubjectEvent {
  final Subject subject;

  DeleteSubject(this.subject) : super([subject]);

  @override
  String toString() {
    return 'DeleteSubject{subject: $subject}';
  }
}
