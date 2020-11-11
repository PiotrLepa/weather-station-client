// ignore: must_be_immutable
import 'package:auto_localized/auto_localized.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/app_flushbar.dart';
import 'package:weather_station/gen/assets.gen.dart';

// ignore: must_be_immutable
class NotificationFlushbar extends AppFlushbar {
  NotificationFlushbar({
    Key key,
    @required BuildContext context,
    @required PlainLocalizedString message,
    @required VoidCallback onDismiss,
    PlainLocalizedString title,
  }) : super(
          key: key,
          title: context.translate(title ?? Strings.notificationFlushbarTitle),
          message: message.get(context),
          backgroundColor: Colors.white,
          icon: Assets.icons.notification.svg(
            width: 24,
            height: 24,
          ),
          onDismiss: onDismiss,
          flushbarPosition: FlushbarPosition.TOP,
          infinityDuration: true,
          boxShadows: [
            BoxShadow(
              color: ThemeProvider.of(context).accentColor,
              // offset: const Offset(0, 3),
              blurRadius: 4,
            )
          ],
        );
}
