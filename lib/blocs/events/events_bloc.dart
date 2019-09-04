import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:scholar_agenda/models/event.dart';

import './events.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventDao eventDao;

  EventsBloc({this.eventDao});

  @override
  EventsState get initialState => InitialEventsState();

  @override
  Stream<EventsState> mapEventToState(
    EventsEvent event,
  ) async* {
    if (event is LoadEvents) {
      yield* _mapLoadEventsToState();
    } else if (event is AddEvent) {
      yield* _mapAddEventToState(event);
    } else if (event is UpdateEvent) {
      yield* _mapUpdateEventToState(event);
    } else if (event is DeleteEvent) {
      yield* _mapDeleteEventToState(event);
    }
  }

  Stream<EventsState> _mapLoadEventsToState() async* {
    final events = await eventDao.getAllEvents();
    yield EventsLoaded(events);
  }

  Stream<EventsState> _mapAddEventToState(AddEvent event) async* {
    if (currentState is EventsLoaded) {
      final id = await eventDao.insertEvent(event.event);
      event.event.id = id;
      final List<Event> updatedEvents =
          List.from((currentState as EventsLoaded).events)..add(event.event);
      yield EventsLoaded(updatedEvents);
    }
  }

  Stream<EventsState> _mapUpdateEventToState(UpdateEvent event) async* {
    if (currentState is EventsLoaded) {
      final List<Event> updatedEvents =
          (currentState as EventsLoaded).events.map((e) {
        return e.id == event.event.id ? event.event : e;
      }).toList();

      yield EventsLoaded(updatedEvents);
      await eventDao.updateEvent(event.event);
    }
  }

  Stream<EventsState> _mapDeleteEventToState(DeleteEvent event) async* {
    if (currentState is EventsLoaded) {
      final updatedEvents = (currentState as EventsLoaded)
          .events
          .where((e) => e.id != event.event.id)
          .toList();
      yield EventsLoaded(updatedEvents);

      await eventDao.deleteEvent(event.event);
    }
  }
}
