part of 'home_pages_bloc.dart';

@freezed
class HomePagesEvent with _$HomePagesEvent {
  const factory HomePagesEvent.bottomNavigationClicked(int index) =
      BottomNavigationClicked;
}
