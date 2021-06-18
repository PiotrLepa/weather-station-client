import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/app_flushbar.dart';

@lazySingleton
class FlushbarHelper {
  // BuildContext get _context => appNavigator.context;
  //
  AppFlushbar? _currentFlushbar;

  void dismiss() {
    _currentFlushbar?.dismiss();
    _currentFlushbar = null;
  }

  Future<void> showError({
    required PlainLocalizedString message,
    PlainLocalizedString? title,
  }) {
    return Future.value(null);
    // _showFlushbar(
    //   flushbar: ErrorFlushbar(
    //     context: _context,
    //     title: title,
    //     message: message,
    //     onDismiss: _onFlushbarDismiss,
    //   ),
    // );
  }

  Future<void> showSuccess({
    required PlainLocalizedString message,
    PlainLocalizedString? title,
  }) {
    return Future.value(null);
    // _showFlushbar(
    //   flushbar: SuccessFlushbar(
    //     context: _context,
    //     title: title,
    //     message: message,
    //     onDismiss: _onFlushbarDismiss,
    //   ),
    // );
  }

  Future<void> showNotification({
    required PlainLocalizedString message,
    PlainLocalizedString? title,
  }) {
    return Future.value(null);
    // _showFlushbar(
    //   flushbar: NotificationFlushbar(
    //     context: _context,
    //     title: title,
    //     message: message,
    //     onDismiss: _onFlushbarDismiss,
    //   ),
    // );
  }

  Future<void> show({
    required Widget title,
    required Widget message,
    required Color backgroundColor,
    required Widget icon,
    required FlatButton mainButton,
    Duration duration = const Duration(seconds: 3),
    bool isDismissible = true,
  }) {
    return Future.value(null);
    // _showFlushbar(
    //   flushbar: AppFlushbar(
    //     title: title,
    //     message: message,
    //     backgroundColor: backgroundColor,
    //     icon: icon,
    //     mainButton: mainButton,
    //     duration: duration,
    //     isDismissible: isDismissible,
    //     onDismiss: _onFlushbarDismiss,
    //   ),
    // );
  }

  Future<void> _showFlushbar({
    required AppFlushbar flushbar,
  }) async {
    return Future.value(null);
    _currentFlushbar?.dismiss();
    _currentFlushbar = flushbar;
    // return navigatorKey.currentState.push(
    //   flushbar_route.showFlushbar<void>(
    //     context: _context,
    //     flushbar: flushbar,
    //   ),
    // );
  }

  void _onFlushbarDismiss() {
    _currentFlushbar = null;
  }
}
