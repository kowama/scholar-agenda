import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:scholar_agenda/models/event.dart';

@immutable
abstract class EventsEvent extends Equatable {
  EventsEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadEvents extends EventsEvent {
  @override
  String toString() {
    return 'LoadEvents{}';
  }
}

class AddEvent extends EventsEvent {
  final Event event;

  AddEvent(this.event) : super([event]);

  @override
  String toString() {
    return 'AddEvent{event: $event}';
  }
}

class UpdateEvent extends EventsEvent {
  final Event event;

  UpdateEvent(this.event) : super([event]);

  @override
  String toString() {
    return 'UpdateEvent{event: $event}';
  }
}

class DeleteEvent extends EventsEvent {
  final Event event;

  DeleteEvent(this.event) : super([event]);

  @override
  String toString() {
    return 'DeleteEvent{event: $event}';
  }
}
