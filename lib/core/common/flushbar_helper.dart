import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar_route.dart' as flushbarRoute;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/app_flushbar.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/error_flushbar.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/success_flushbar.dart';
import 'package:weather_station/presentation/app.dart';

@lazySingleton
class FlushbarHelper {
  BuildContext get _context => ExtendedNavigator.root.context;

  bool _isFlushbarVisible = false;

  void dismiss() {
    if (_isFlushbarVisible) {
      _isFlushbarVisible = false;
      ExtendedNavigator.root.pop();
    }
  }

  Future<void> showError({
    @required RKString message,
    RKString title,
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
    @required String message,
    String title,
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
    if (_isFlushbarVisible) {
      return;
    }
    _isFlushbarVisible = true;
    await Future.delayed(Duration(milliseconds: 200));
    return navigatorKey.currentState.push(
      flushbarRoute.showFlushbar(
        context: _context,
        flushbar: flushbar,
      ),
    );
  }

  void _onFlushbarDismiss() {
    _isFlushbarVisible = false;
  }
}
