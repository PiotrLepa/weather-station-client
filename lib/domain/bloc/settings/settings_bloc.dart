import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';

part 'settings_bloc.freezed.dart';

part 'settings_event.dart';

part 'settings_state.dart';

@injectable
class SettingsBloc extends CustomBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const RenderPage());

  @override
  Future<void> onEvent(SettingsEvent event) async {
    await event.map(
      onConfigureWifiClicked: _mapOnConfigureWifiClicked,
    );
  }

  Future<void> _mapOnConfigureWifiClicked(
    OnConfigureWifiClicked event,
  ) async {
    appNavigator.pushConfigureArduinoScreen();
  }
}
