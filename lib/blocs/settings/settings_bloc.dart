import 'dart:async';
import 'package:bloc/bloc.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  @override
  SettingsState get initialState => SettingLoading();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is LoadSettings) {
      yield* _mapLoadSettingsToState();
    }
  }

  Stream<SettingsState> _mapLoadSettingsToState() async* {
//    try {
//      yield* SettingsLoaded();
//    } catch (error) {
//      yield* ErrorSettingsNotLoaded(error);
//    }
  }
}
