part of 'home_bloc.dart';

@freezed
abstract class HomeEvent with _$HomeEvent implements BlocEvent {
  const factory HomeEvent.onBottomNavigationClicked(int index) =
      OnBottomNavigationClicked;
}
