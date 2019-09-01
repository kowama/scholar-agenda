import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:scholar_agenda/models/models.dart';
import './timetables.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  final TimetableDao timetableDao;

  TimetableBloc({@required this.timetableDao});

  @override
  TimetableState get initialState => TimetablesLoading();

  @override
  Stream<TimetableState> mapEventToState(
    TimetableEvent event,
  ) async* {
    if (event is LoadTimetables) {
      yield* _mapLoadTimetablesToState();
    } else if (event is AddTimetable) {
      yield* _mapAddTimetableToState(event);
    } else if (event is UpdateTimetable) {
      yield* _mapUpdateTimetableToState(event);
    } else if (event is DeleteTimetable) {
      yield* _mapDeleteTimetableToState(event);
    }
  }

  Stream<TimetableState> _mapLoadTimetablesToState() async* {
    try {
      final timetables = await timetableDao.getAllTimetables();
      yield TimetablesLoaded(timetables);
    } catch (error) {
      yield ErrorTimetablesNotLoaded(error);
    }
  }

  Stream<TimetableState> _mapAddTimetableToState(AddTimetable event) async* {
    if (currentState is TimetablesLoaded) {
      final id = await timetableDao.insertTimetable(event.timetable);
      event.timetable.id = id;

      final List<Timetable> updatedTimetables =
          List.from((currentState as TimetablesLoaded).timetables)
            ..add(event.timetable);

      yield TimetablesLoaded(updatedTimetables);
    }
  }

  Stream<TimetableState> _mapUpdateTimetableToState(
      UpdateTimetable event) async* {
    if (currentState is TimetablesLoaded) {
      final List<Timetable> updatedTimetables =
          (currentState as TimetablesLoaded).timetables.map((timetable) {
        return timetable.id == event.timetable.id ? event.timetable : timetable;
      }).toList();
      yield TimetablesLoaded(updatedTimetables);
      await timetableDao.updateTimetable(event.timetable);
    }
  }

  Stream<TimetableState> _mapDeleteTimetableToState(
      DeleteTimetable event) async* {
    if (currentState is TimetablesLoaded) {
      final updatedTimetables = (currentState as TimetablesLoaded)
          .timetables
          .where((timetable) => timetable.id != event.timetable.id)
          .toList();
      yield TimetablesLoaded(updatedTimetables);

      await timetableDao.deleteTimetable(event.timetable);
    }
  }
}
