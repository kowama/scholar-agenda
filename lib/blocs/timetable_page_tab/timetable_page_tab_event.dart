import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'timetable_page_tab_state.dart';

@immutable
abstract class TimetablePageTabEvent extends Equatable {
  TimetablePageTabEvent([List props = const <dynamic>[]]) : super(props);
}

class ToggleTab extends TimetablePageTabEvent {
  @override
  String toString() {
    return 'ToggleTab{}';
  }
}

class UpdateTab extends TimetablePageTabEvent {
  final TimetablePageTab timetablePageTab;

  UpdateTab(this.timetablePageTab);

  @override
  String toString() {
    return 'UpdateTab{timetablePageTab: $timetablePageTab}';
  }
}
