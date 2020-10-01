import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/domain/bloc/event_cubit.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends EventCubit<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.changePage(0));

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
