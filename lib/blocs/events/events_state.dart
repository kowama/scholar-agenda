import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/event.dart';

@immutable
abstract class EventsState extends Equatable {
  EventsState([List props = const <dynamic>[]]) : super(props);
}
class EventsLoading extends EventsState {
  @override
  String toString() {
    return 'EventsLoading{}';
  }
}

class EventsLoaded extends EventsState {
  final List<Event> events;

  EventsLoaded(this.events) : super([events]);

  @override
  String toString() {
    return 'EventsLoaded{events: $events}';
  }
}
