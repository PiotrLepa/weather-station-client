import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/domain/cubit/cubit_event.dart';
import 'package:weather_station/core/domain/cubit/cubit_state.dart';
import 'package:weather_station/core/domain/cubit/event_cubit.dart';

part 'home_bloc.freezed.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends EventCubit<HomeEvent, HomeState> {
  HomeCubit() : super(const HomeState.changePage(0));

  @override
  Future<void> onEvent(HomeEvent event) async {
    await event.map(
      onBottomNavigationTapped: _mapOnBottomNavigationTapped,
    );
  }

  Future<void> _mapOnBottomNavigationTapped(
    OnBottomNavigationTapped event,
  ) async {
    emit(ChangePage(event.index));
  }
}
