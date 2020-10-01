import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';

abstract class CustomBloc<E extends BlocEvent, S extends BlocState>
    extends Cubit<S> {
  CustomBloc(S state) : super(state);

  void add(E event) {
    onEvent(event);
  }

  Future<void> onEvent(E event);
}
