// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/app_flushbar.dart';

// ignore: must_be_immutable
class SuccessFlushbar extends AppFlushbar {
  SuccessFlushbar({
    Key key,
    @required BuildContext context,
    @required String message,
    @required VoidCallback onDismiss,
    String title,
  }) : super(
          title: title ?? context.translateKey('successFlushbarTitle'),
          message: message,
          backgroundColor: Theme.of(context).primaryColor,
          onDismiss: onDismiss,
        );
}
