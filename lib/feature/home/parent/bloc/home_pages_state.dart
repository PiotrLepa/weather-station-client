part of 'home_pages_bloc.dart';

@freezed
class HomePagesState with _$HomePagesState {
  factory HomePagesState.initial() => const HomePagesState(
        currentPageIndex: 0,
      );

  const factory HomePagesState({required int currentPageIndex}) =
      _HomePagesState;
}
