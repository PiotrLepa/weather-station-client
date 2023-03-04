import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_pages_bloc.freezed.dart';
part 'home_pages_event.dart';
part 'home_pages_state.dart';

@injectable
class HomePagesBloc extends Bloc<HomePagesEvent, HomePagesState> {
  HomePagesBloc() : super(HomePagesState.initial()) {
    on<BottomNavigationClicked>(_onBottomNavigationClicked);
  }

  void _onBottomNavigationClicked(
    BottomNavigationClicked event,
    Emitter<HomePagesState> emit,
  ) {
    if (event.index == 2) {
      throw Exception();
    }
    emit(state.copyWith(
      currentPageIndex: event.index,
    ));
  }
}
