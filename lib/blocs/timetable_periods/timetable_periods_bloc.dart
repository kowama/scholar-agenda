import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:scholar_agenda/models/period.dart';

import 'timetable_periods_event.dart';
import 'timetable_periods_state.dart';

class TimetablePeriodsBloc
    extends Bloc<TimetablePeriodsEvent, TimetablePeriodsState> {
  final PeriodDao periodDao;

  TimetablePeriodsBloc({@required this.periodDao});

  @override
  TimetablePeriodsState get initialState => TimetableNotSet();

  @override
  Stream<TimetablePeriodsState> mapEventToState(
    TimetablePeriodsEvent event,
  ) async* {
    if (event is LoadTimetablePeriods) {
      yield* _loadTimetablePeriodsToState(event);
    } else if (event is AddPeriod) {
      yield* _mapAddPeriodToState(event);
    } else if (event is UpdatePeriod) {
      yield* _mapUpdatePeriodToState(event);
    } else if (event is DeletePeriod) {
      yield* _mapDeletePeriodToEvent(event);
    }
  }

  Stream<TimetablePeriodsState> _loadTimetablePeriodsToState(
      LoadTimetablePeriods event) async* {
    yield TimetablePeriodsLoading(event.timetable);
    final periods = await periodDao.getAllWithTimetable(event.timetable);
    yield TimetablePeriodsLoaded(event.timetable, periods);
  }

  Stream<TimetablePeriodsState> _mapAddPeriodToState(AddPeriod event) async* {
    if (currentState is TimetablePeriodsLoaded) {
      final id = await periodDao.insertPeriod(event.period);
      event.period.id = id;
      final List<Period> updatedPeriods =
          List.from((currentState as TimetablePeriodsLoaded).periods)
            ..add(event.period);
      yield TimetablePeriodsLoaded(event.period.timetable, updatedPeriods);
    }
  }

  Stream<TimetablePeriodsState> _mapUpdatePeriodToState(
      UpdatePeriod event) async* {
    if (currentState is TimetablePeriodsLoaded) {
      final List<Period> updatedPeriods =
          (currentState as TimetablePeriodsLoaded).periods.map((period) {
        return period.id == event.period.id ? event.period : period;
      }).toList();
      yield TimetablePeriodsLoaded(event.period.timetable, updatedPeriods);
      await periodDao.updatePeriod(event.period);
    }
  }

  Stream<TimetablePeriodsState> _mapDeletePeriodToEvent(
      DeletePeriod event) async* {
    if (currentState is TimetablePeriodsLoaded) {
      final updatedPeriods = (currentState as TimetablePeriodsLoaded)
          .periods
          .where((period) => period.id != event.period.id)
          .toList();
      yield TimetablePeriodsLoaded(event.period.timetable, updatedPeriods);
      await periodDao.deletePeriod(event.period);
    }
  }
}
