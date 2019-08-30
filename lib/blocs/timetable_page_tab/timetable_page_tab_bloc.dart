import 'dart:async';
import 'package:bloc/bloc.dart';
import './timetable_page_tab.dart';

class TimetablePageTabBloc
    extends Bloc<TimetablePageTabEvent, TimetablePageTab> {
  @override
  TimetablePageTab get initialState => TimetablePageTab.weekView;

  @override
  Stream<TimetablePageTab> mapEventToState(
    TimetablePageTabEvent event,
  ) async* {
    if (event is ToggleTab) {
      yield currentState == TimetablePageTab.weekView
          ? TimetablePageTab.daysTaskView
          : TimetablePageTab.weekView;
    }
    if (event is UpdateTab) {
      yield event.timetablePageTab;
    }
  }
}
