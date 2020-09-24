import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState.changePage(0));

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is OnBottomNavigationTapped) {
      yield* _mapOnBottomNavigationTappedEvent(event);
    }
  }

  Stream<HomeState> _mapOnBottomNavigationTappedEvent(
    OnBottomNavigationTapped event,
  ) async* {
    yield HomeState.changePage(event.index);
  }
}
