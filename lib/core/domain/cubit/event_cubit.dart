import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/domain/cubit/cubit_event.dart';
import 'package:weather_station/core/domain/cubit/cubit_state.dart';

abstract class EventCubit<E extends CubitEvent, S extends CubitState>
    extends Cubit<S> {
  EventCubit(S state) : super(state);

  void add(E event) {
    onEvent(event);
  }

  Future<void> onEvent(E event);
}
