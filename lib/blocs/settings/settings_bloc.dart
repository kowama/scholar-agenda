import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:scholar_agenda/services/preferences.dart';

import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final preferences = Preferences();

  @override
  SettingsState get initialState => SettingLoading();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is LoadSettings) {
      yield* _mapLoadSettingsToState();
    } else if (event is UpdateSettings) {
      yield* _mapUpdateSettingsToState(event);
    }
  }

  Stream<SettingsState> _mapLoadSettingsToState() async* {
    final timetable = await preferences.getDefaultTimetable();
    yield SettingsLoaded(timetable);
  }

  Stream<SettingsState> _mapUpdateSettingsToState(UpdateSettings event) async* {
    yield SettingsLoaded(event.timetable);
    preferences.updateDefaultTimetable(event.timetable);
  }
}
