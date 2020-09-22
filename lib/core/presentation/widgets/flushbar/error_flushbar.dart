import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/app_flushbar.dart';

// ignore: must_be_immutable
class ErrorFlushbar extends AppFlushbar {
  ErrorFlushbar({
    Key key,
    @required BuildContext context,
    @required PlainLocalizedString message,
    @required VoidCallback onDismiss,
    PlainLocalizedString title,
  }) : super(
          title: context.translate(title ?? Strings.errorFlushbarTitle),
          message: message.get(context),
          backgroundColor: Theme.of(context).errorColor,
          icon: Icon(
            Icons.warning,
            color: Colors.white,
          ),
          onDismiss: onDismiss,
        );
}
