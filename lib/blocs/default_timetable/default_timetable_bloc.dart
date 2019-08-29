import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../blocs.dart';
import 'default_timetable_event.dart';
import 'default_timetable_state.dart';

class DefaultTimetableBloc
    extends Bloc<DefaultTimetableEvent, DefaultTimetableState> {
  final SettingsBloc settingsBloc;
  StreamSubscription settingsSubscription;

  DefaultTimetableBloc({@required this.settingsBloc}) {
    settingsSubscription = settingsBloc.state.listen((state) {
      if (state is SettingsLoaded) {
        dispatch(UpdateDefaultTimetable(state.defaultTimetable));
      }
    });
  }

  @override
  DefaultTimetableState get initialState => DefaultTimetableLoading();

  @override
  void dispose() {
    settingsSubscription.cancel();
    super.dispose();
  }

  @override
  Stream<DefaultTimetableState> mapEventToState(
    DefaultTimetableEvent event,
  ) async* {
    if (event is LoadDefaultTimetable) {
      yield* _mapLoadDefaultTimetableToState();
    } else if (event is UpdateDefaultTimetable) {
      yield* _mapUpdateDefaultTimetableToState(event);
    }
  }

  Stream<DefaultTimetableState> _mapLoadDefaultTimetableToState() async* {
    if (settingsBloc.state is SettingsLoaded) {
      final defaultTimetable =
          (settingsBloc.state as SettingsLoaded).defaultTimetable;
      if (defaultTimetable == null) {
        yield DefaultTimetableNotSet();
      } else {
        yield DefaultTimetableLoaded(defaultTimetable);
      }
    }
  }

  Stream<DefaultTimetableState> _mapUpdateDefaultTimetableToState(
      UpdateDefaultTimetable event) async* {
    if (currentState is DefaultTimetableLoaded ||
        currentState is DefaultTimetableNotSet) {
      if (event.timetable == null) {
        yield DefaultTimetableNotSet();
      } else {
        yield DefaultTimetableLoaded(event.timetable);
        settingsBloc.dispatch(UpdateSettings(timetable: event.timetable));
      }
    }
  }
}
