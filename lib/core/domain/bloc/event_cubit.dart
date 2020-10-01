import 'package:flutter_bloc/flutter_bloc.dart';

abstract class EventCubit<Event, State> extends Cubit<State> {
  EventCubit(State state) : super(state);

  void add(Event event) {
    onEvent(event);
  }

  Future<void> onEvent(Event event);
}
