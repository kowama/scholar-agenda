import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:scholar_agenda/models/models.dart';
import './periods.dart';

class PeriodsBloc extends Bloc<PeriodsEvent, PeriodsState> {
  final PeriodDao periodDao;

  PeriodsBloc({@required this.periodDao});

  @override
  PeriodsState get initialState => InitialPeriodsState();

  @override
  Stream<PeriodsState> mapEventToState(
    PeriodsEvent event,
  ) async* {
    if (event is AddPeriod) {
      yield* _mapAddPeriodToState(event);
    } else if (event is UpdatePeriod) {
      yield* _mapUpdatePeriodToState(event);
    } else if (event is DeletePeriod) {
      yield* _mapDeletePeriodToEvent(event);
    }
  }

  Stream<PeriodsState> _mapAddPeriodToState(AddPeriod event) async* {
    await periodDao.insertPeriod(event.period);
  }

  Stream<PeriodsState> _mapUpdatePeriodToState(UpdatePeriod event) async* {
    await periodDao.updatePeriod(event.period);
  }

  Stream<PeriodsState> _mapDeletePeriodToEvent(DeletePeriod event) async* {
    await periodDao.deletePeriod(event.period);
  }
}
