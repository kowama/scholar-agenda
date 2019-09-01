import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/models.dart';

import 'subjects_event.dart';
import 'subjects_state.dart';

class SubjectsBloc extends Bloc<SubjectsEvent, SubjectsState> {
  final SubjectDao subjectDao;

  SubjectsBloc({@required this.subjectDao}) : assert(subjectDao != null);

  @override
  SubjectsState get initialState => SubjectsLoading();

  @override
  Stream<SubjectsState> mapEventToState(
    SubjectsEvent event,
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

  Stream<SubjectsState> _mapLoadSubjectsToState() async* {
    try {
      final subjects = await subjectDao.getAllSubjects();
      yield SubjectsLoaded(subjects);
    } catch (error) {
      yield ErrorSubjectsNotLoaded(error);
    }
  }

  Stream<SubjectsState> _mapAddSubjectToState(AddSubject event) async* {
    if (currentState is SubjectsLoaded) {
      final id = await subjectDao.insertSubject(event.subject);
      event.subject.id = id;
      final List<Subject> updatedSubjects =
          List.from((currentState as SubjectsLoaded).subjects)
            ..add(event.subject);
      yield SubjectsLoaded(updatedSubjects);
    }
  }

  Stream<SubjectsState> _mapUpdateSubjectToState(UpdateSubject event) async* {
    if (currentState is SubjectsLoaded) {
      final List<Subject> updatedSubjects =
          (currentState as SubjectsLoaded).subjects.map((subject) {
        return subject.id == event.subject.id ? event.subject : subject;
      }).toList();
      yield SubjectsLoaded(updatedSubjects);
      await subjectDao.updateSubject(event.subject);
    }
  }

  Stream<SubjectsState> _mapDeleteSubjectToState(DeleteSubject event) async* {
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
