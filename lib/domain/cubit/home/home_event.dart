part of 'home_cubit.dart';

@freezed
abstract class HomeEvent with _$HomeEvent implements CubitEvent {
  const factory HomeEvent.onBottomNavigationTapped(int index) =
      OnBottomNavigationTapped;
}
