import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/app_flushbar.dart';

// ignore: must_be_immutable
class ErrorFlushbar extends AppFlushbar {
  ErrorFlushbar({
    Key? key,
    required BuildContext context,
    required PlainLocalizedString message,
    required VoidCallback onDismiss,
    PlainLocalizedString? title,
  }) : super(
          key: key,
          title: Text(
            context.translate(title ?? Strings.errorFlushbarTitle),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: ThemeProvider.of(context).textColorInverted,
            ),
          ),
          message: Text(
            message.get(context),
            style: TextStyle(
              fontSize: 14,
              color: ThemeProvider.of(context).textColorInverted,
            ),
          ),
          backgroundColor: Theme.of(context).errorColor,
          icon: const Icon(
            Icons.warning,
            color: Colors.white,
          ),
          onDismiss: onDismiss,
        );
}
