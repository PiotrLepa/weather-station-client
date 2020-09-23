import 'package:auto_localized/auto_localized.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar_route.dart' as flushbar_route;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/app_flushbar.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/error_flushbar.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/success_flushbar.dart';
import 'package:weather_station/presentation/app.dart';

@lazySingleton
class FlushbarHelper {
  BuildContext get _context => ExtendedNavigator.root.context;

  AppFlushbar _currentFlushbar;

  void dismiss() {
    _currentFlushbar?.dismiss();
    _currentFlushbar = null;
  }

  Future<void> showError({
    @required PlainLocalizedString message,
    PlainLocalizedString title,
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
    @required PlainLocalizedString message,
    PlainLocalizedString title,
  }) =>
      _showFlushbar(
        flushbar: SuccessFlushbar(
          context: _context,
          title: title,
          message: message,
          onDismiss: _onFlushbarDismiss,
        ),
      );

  Future<void> show({
    String title,
    String message,
    Color backgroundColor,
    Widget icon,
    FlatButton mainButton,
    bool infinityDuration = false,
    bool isDismissible = true,
  }) =>
      _showFlushbar(
        flushbar: AppFlushbar(
          title: title,
          message: message,
          backgroundColor: backgroundColor,
          icon: icon,
          mainButton: mainButton,
          infinityDuration: infinityDuration,
          isDismissible: isDismissible,
          onDismiss: _onFlushbarDismiss,
        ),
      );

  Future<void> _showFlushbar({
    @required AppFlushbar flushbar,
  }) async {
    _currentFlushbar?.dismiss();
    _currentFlushbar = flushbar;
    return navigatorKey.currentState.push(
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
