// ignore: must_be_immutable
import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/app_flushbar.dart';

// ignore: must_be_immutable
class SuccessFlushbar extends AppFlushbar {
  SuccessFlushbar({
    Key key,
    @required BuildContext context,
    @required PlainLocalizedString message,
    @required VoidCallback onDismiss,
    PlainLocalizedString title,
  }) : super(
    key: key,
          title: context.translate(title ?? Strings.successFlushbarTitle),
          message: message.get(context),
          backgroundColor: ThemeProvider.of(context).accentColor,
          onDismiss: onDismiss,
        );
}
