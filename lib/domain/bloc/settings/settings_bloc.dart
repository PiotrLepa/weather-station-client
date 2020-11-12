import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/data/network/exception/api/api_exception.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/core/domain/error/error_translator.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/utils/notification/notification_subscriber.dart';

part 'settings_bloc.freezed.dart';

part 'settings_event.dart';

part 'settings_state.dart';

@injectable
class SettingsBloc extends CustomBloc<SettingsEvent, SettingsState> {
  final NotificationSubscriber _notificationSubscriber;
  final ErrorTranslator _errorTranslator;
  final FlushbarHelper _flushbarHelper;

  SettingsBloc(
    this._notificationSubscriber,
    this._errorTranslator,
    this._flushbarHelper,
  ) : super(const Loading());

  @override
  Future<void> onEvent(SettingsEvent event) async {
    await event.map(
      pageStarted: _maOnPageStarted,
      configureWifiClicked: _mapConfigureWifiClicked,
      aboutAppClicked: _mapAboutAppClicked,
      pushNotificationsSwitchChanged: _mapPushNotificationsSwitchChanged,
    );
  }

  Future<void> _maOnPageStarted(
    PageStarted event,
  ) async {
    emit(RenderItems(
      pushEnabled: await _notificationSubscriber.arePushEnabled,
    ));
  }

  Future<void> _mapConfigureWifiClicked(
    ConfigureWifiClicked event,
  ) async {
    appNavigator.pushConfigureStationScreen();
  }

  Future<void> _mapAboutAppClicked(
    AboutAppClicked event,
  ) async {
    appNavigator.pushAboutAppScreen();
  }

  Future<void> _mapPushNotificationsSwitchChanged(
    PushNotificationsSwitchChanged event,
  ) async {
    final enable = event.isChecked;
    final request = enable
        ? _notificationSubscriber
        .subscribe(NotificationSubscriber.topicRainDetected)
        : _notificationSubscriber
        .unsubscribe(NotificationSubscriber.topicRainDetected);

    await request
        .then((value) => emit(RenderItems(pushEnabled: enable)))
        .catchError(_handleNotificationSubscriberError);
  }

  void _handleNotificationSubscriberError(Object error) {
    final message = error is ApiException
        ? _errorTranslator.translate(error)
        : Strings.apiErrorUnknown;
    _flushbarHelper.showError(message: message);
  }
}
