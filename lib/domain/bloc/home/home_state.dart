part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState implements BlocState {
  const factory HomeState.changePage(int index) = ChangePage;
}
