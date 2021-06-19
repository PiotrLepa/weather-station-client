import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class AppFlushbar extends Flushbar<void> {
  AppFlushbar({
    Key? key,
    required Widget title,
    required Widget message,
    required VoidCallback onDismiss,
    Color? backgroundColor,
    Widget? icon,
    FlatButton? mainButton,
    FlushbarPosition flushbarPosition = FlushbarPosition.BOTTOM,
    Duration duration = const Duration(seconds: 3),
    bool isDismissible = true,
    List<BoxShadow>? boxShadows,
  }) : super(
    key: key,
          titleText: title,
          messageText: message,
          isDismissible: isDismissible,
          icon: icon,
          shouldIconPulse: false,
          backgroundColor: backgroundColor ?? const Color(0xFF303030),
          mainButton: mainButton,
          flushbarStyle: FlushbarStyle.FLOATING,
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(16),
          duration: duration,
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
