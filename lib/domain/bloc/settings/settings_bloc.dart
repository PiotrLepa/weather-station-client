import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/core/domain/call/call_wrapper.dart';
import 'package:weather_station/domain/utils/notification/notification_subscriber.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

@injectable
class SettingsBloc extends CustomBloc<SettingsEvent, SettingsState> {
  final NotificationSubscriber _notificationSubscriber;
  final FlushbarHelper _flushbarHelper;

  SettingsBloc(
    this._notificationSubscriber,
    this._flushbarHelper,
  ) : super(const Loading());

  @override
  Future<void> onEvent(SettingsEvent event) async {
    await event.map(
      pageStarted: _mapPageStarted,
      configureWifiClicked: _mapConfigureWifiClicked,
      aboutAppClicked: _mapAboutAppClicked,
      pushNotificationsSwitchChanged: _mapPushNotificationsSwitchChanged,
    );
  }

  Future<void> _mapPageStarted(
    PageStarted event,
  ) async {
    emit(RenderItems(
      pushEnabled: await _notificationSubscriber.arePushEnabled,
    ));
  }

  Future<void> _mapConfigureWifiClicked(
    ConfigureWifiClicked event,
  ) async {
    emit(const PushConfigureStationScreen());
    emit(const Nothing());
  }

  Future<void> _mapAboutAppClicked(
    AboutAppClicked event,
  ) async {
    emit(const PushAboutAppScreen());
    emit(const Nothing());
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

    wrapCall<void>(
      call: request,
      onSuccess: (_) {
        emit(RenderItems(pushEnabled: enable));
      },
      onError: (_, message) {
        _flushbarHelper.showError(message: message);
      },
    );
  }
}
