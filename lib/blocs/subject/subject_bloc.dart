import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:scholar_agenda/models/models.dart';

import 'subject_event.dart';
import 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectDao subjectDao;

  SubjectBloc({@required this.subjectDao});

  @override
  SubjectState get initialState => LoadedSubjectsState();

  @override
  Stream<SubjectState> mapEventToState(
    SubjectEvent event,
  ) async* {
    if (event is LoadSubjectsEvent) {
      yield* _mapLoadSubjectEventToState();
    } else if (event is AddSubjectEvent) {
      yield* _mapAddSubjectEventToState(event);
    } else if (event is UpdateSubjectEvent) {
      yield* _mapUpdateSubjectEventToState(event);
    } else if (event is DeleteSubjectEvent) {
      yield* _mapDeleteSubjectEventToState(event);
    }
  }

  Stream<SubjectState> _mapLoadSubjectEventToState() async* {
    try {
      final subjects = await subjectDao.getAllSubjects();
      yield LoadedSubjectsState(subjects);
    } catch (error) {
      yield NotLoadedSubjectsState(error);
    }
  }

  Stream<SubjectState> _mapAddSubjectEventToState(
      AddSubjectEvent event) async* {
    if (currentState is LoadedSubjectsState) {
      final List<Subject> updatedSubjects =
          List.from((currentState as LoadedSubjectsState).subjects)
            ..add(event.subject);
      yield LoadedSubjectsState(updatedSubjects);
      subjectDao.insertSubject(event.subject);
    }
  }

  Stream<SubjectState> _mapUpdateSubjectEventToState(
      UpdateSubjectEvent event) async* {
    if (currentState is LoadedSubjectsState) {
      final List<Subject> updatedSubjects =
          (currentState as LoadedSubjectsState).subjects.map((subject) {
        return subject.id == event.updatedSubject.id
            ? event.updatedSubject
            : subject;
      }).toList();
      yield LoadedSubjectsState(updatedSubjects);
      await subjectDao.updateSubject(event.updatedSubject);
    }
  }

  Stream<SubjectState> _mapDeleteSubjectEventToState(
      DeleteSubjectEvent event) async* {
    if (currentState is LoadedSubjectsState) {
      final updatedSubjects = (currentState as LoadedSubjectsState)
          .subjects
          .where((subject) => subject.id != event.deletedSubject.id)
          .toList();
      yield LoadedSubjectsState(updatedSubjects);

      await subjectDao.deleteSubject(event.deletedSubject);
    }
  }
}
