part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState implements CubitState {
  const factory HomeState.changePage(int index) = ChangePage;
}
