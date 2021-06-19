import 'package:another_flushbar/flushbar_route.dart' as flushbar_route;
import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/app_flushbar.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/error_flushbar.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/notification_flushbar.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/success_flushbar.dart';

@lazySingleton
class FlushbarHelper {
  BuildContext get _context => navigatorKey.currentContext!;

  //
  AppFlushbar? _currentFlushbar;

  void dismiss() {
    _currentFlushbar?.dismiss();
    _currentFlushbar = null;
  }

  Future<void> showError({
    required PlainLocalizedString message,
    PlainLocalizedString? title,
  }) =>
      _showFlushbar(
        flushbar: ErrorFlushbar(
          context: _context,
          title: title,
          message: message,
          onDismiss: _onFlushbarDismiss,
        ),
      );

  Future<void> showSuccess({
    required PlainLocalizedString message,
    PlainLocalizedString? title,
  }) =>
      _showFlushbar(
        flushbar: SuccessFlushbar(
          context: _context,
          title: title,
          message: message,
          onDismiss: _onFlushbarDismiss,
        ),
      );

  Future<void> showNotification({
    required PlainLocalizedString message,
    PlainLocalizedString? title,
  }) =>
      _showFlushbar(
        flushbar: NotificationFlushbar(
          context: _context,
          title: title,
          message: message,
          onDismiss: _onFlushbarDismiss,
        ),
      );

  Future<void> show({
    required Widget title,
    required Widget message,
    required Color backgroundColor,
    required Widget icon,
    required FlatButton mainButton,
    Duration duration = const Duration(seconds: 3),
    bool isDismissible = true,
  }) =>
      _showFlushbar(
        flushbar: AppFlushbar(
          title: title,
          message: message,
          backgroundColor: backgroundColor,
          icon: icon,
          mainButton: mainButton,
          duration: duration,
          isDismissible: isDismissible,
          onDismiss: _onFlushbarDismiss,
        ),
      );

  Future<void> _showFlushbar({
    required AppFlushbar flushbar,
  }) async {
    _currentFlushbar?.dismiss();
    _currentFlushbar = flushbar;
    return navigatorKey.currentState?.push<void>(
      flushbar_route.showFlushbar<void>(
        context: _context,
        flushbar: flushbar,
      ),
    );
  }

  void _onFlushbarDismiss() {
    _currentFlushbar = null;
  }
}
