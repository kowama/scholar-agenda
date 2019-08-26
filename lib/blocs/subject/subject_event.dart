import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

@immutable
abstract class SubjectEvent extends Equatable {
  SubjectEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadSubjectsEvent extends SubjectEvent {
  @override
  String toString() => 'LoadSubjects';
}

class AddSubjectEvent extends SubjectEvent {
  final Subject subject;

  AddSubjectEvent(this.subject) : super([subject]);

  @override
  String toString() => 'AddSubject { Subject: $Subject }';
}

class UpdateSubjectEvent extends SubjectEvent {
  final Subject updatedSubject;

  UpdateSubjectEvent(this.updatedSubject) : super([updatedSubject]);

  @override
  String toString() => 'UpdateSubject { updatedSubject: $updatedSubject }';
}

class DeleteSubjectEvent extends SubjectEvent {
  final Subject deletedSubject;

  DeleteSubjectEvent(this.deletedSubject) : super([deletedSubject]);

  @override
  String toString() => 'DeleteSubject { Subject: $deletedSubject }';
}
