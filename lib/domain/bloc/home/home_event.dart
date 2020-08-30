part of 'home_bloc.dart';

@freezed
abstract class HomeEvent with _$HomeEvent {
  const factory HomeEvent.pageStarted() = PageStarted;

  const factory HomeEvent.onCardClicked() = OnCardClicked;
}
