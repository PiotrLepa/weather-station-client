import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/router/router.gr.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState.renderPage());

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is OnConfigureWifiClicked) {
      mapOnConfigureWifiClicked(event);
    }
  }

  void mapOnConfigureWifiClicked(
    OnConfigureWifiClicked event,
  ) {
    ExtendedNavigator.root.push(Routes.configureArduinoScreen);
  }
}
