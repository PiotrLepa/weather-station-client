part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent implements BlocEvent {
  const factory HomeEvent.bottomNavigationClicked(int index) =
      BottomNavigationClicked;
}
