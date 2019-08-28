import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

import 'subjects_event.dart';
import 'subjects_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectDao subjectDao;

  SubjectBloc({@required this.subjectDao}) : assert(subjectDao != null);

  @override
  SubjectState get initialState => SubjectsLoading();

  @override
  Stream<SubjectState> mapEventToState(
    SubjectEvent event,
  ) async* {
    if (event is LoadSubjects) {
      yield* _mapLoadSubjectsToState();
    } else if (event is AddSubject) {
      yield* _mapAddSubjectToState(event);
    } else if (event is UpdateSubject) {
      yield* _mapUpdateSubjectToState(event);
    } else if (event is DeleteSubject) {
      yield* _mapDeleteSubjectToState(event);
    }
  }

  Stream<SubjectState> _mapLoadSubjectsToState() async* {
    try {
      final subjects = await subjectDao.getAllSubjects();
      yield SubjectsLoaded(subjects);
    } catch (error) {
      yield ErrorSubjectsNotLoaded(error);
    }
  }

  Stream<SubjectState> _mapAddSubjectToState(AddSubject event) async* {
    if (currentState is SubjectsLoaded) {
      final List<Subject> updatedSubjects =
          List.from((currentState as SubjectsLoaded).subjects)
            ..add(event.subject);
      yield SubjectsLoaded(updatedSubjects);
      subjectDao.insertSubject(event.subject);
    }
  }

  Stream<SubjectState> _mapUpdateSubjectToState(UpdateSubject event) async* {
    if (currentState is SubjectsLoaded) {
      final List<Subject> updatedSubjects =
          (currentState as SubjectsLoaded).subjects.map((subject) {
        return subject.id == event.subject.id ? event.subject : subject;
      }).toList();
      yield SubjectsLoaded(updatedSubjects);
      await subjectDao.updateSubject(event.subject);
    }
  }

  Stream<SubjectState> _mapDeleteSubjectToState(DeleteSubject event) async* {
    if (currentState is SubjectsLoaded) {
      final updatedSubjects = (currentState as SubjectsLoaded)
          .subjects
          .where((subject) => subject.id != event.subject.id)
          .toList();
      yield SubjectsLoaded(updatedSubjects);

      await subjectDao.deleteSubject(event.subject);
    }
  }
}
