import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class AppFlushbar extends Flushbar<void> {
  AppFlushbar({
    Key key,
    @required String title,
    @required String message,
    @required VoidCallback onDismiss,
    Color backgroundColor,
    Widget icon,
    FlatButton mainButton,
    FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM,
    bool infinityDuration = false,
    bool isDismissible = true,
    List<BoxShadow> boxShadows,
  }) : super(
    key: key,
          title: title,
          message: message,
          isDismissible: isDismissible,
          icon: icon,
          shouldIconPulse: false,
          backgroundColor: backgroundColor ?? const Color(0xFF303030),
          mainButton: mainButton,
          flushbarStyle: FlushbarStyle.FLOATING,
          margin: const EdgeInsets.all(8),
          borderRadius: 16,
          duration: infinityDuration ? null : const Duration(seconds: 3),
          flushbarPosition: flushbarPosition,
          boxShadows: boxShadows ??
              [
                const BoxShadow(
                  color: Color(0x44FFFFFF),
                  offset: Offset(0, 3),
                  blurRadius: 4,
                )
              ],
          onStatusChanged: (status) {
            if (status == FlushbarStatus.DISMISSED) onDismiss();
          },
        );
}
