import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends CustomBloc<HomeEvent, HomeState> {
  HomeBloc() : super(const ChangePage(0));

  @override
  Future<void> onEvent(HomeEvent event) async {
    await event.map(
      bottomNavigationClicked: _mapBottomNavigationClicked,
    );
  }

  Future<void> _mapBottomNavigationClicked(
    BottomNavigationClicked event,
  ) async {
    emit(ChangePage(event.index));
  }
}
