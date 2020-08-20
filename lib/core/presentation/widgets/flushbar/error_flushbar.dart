import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/presentation/widgets/flushbar/app_flushbar.dart';

// ignore: must_be_immutable
class ErrorFlushbar extends AppFlushbar {
  ErrorFlushbar({
    Key key,
    @required BuildContext context,
    @required RawKeyString message,
    @required VoidCallback onDismiss,
    RawKeyString title,
  }) : super(
          title: title ?? context.translateKey('errorFlushbarTitle'),
          message: context.translate(message),
          backgroundColor: Theme.of(context).errorColor,
          icon: Icon(
            Icons.warning,
            color: Colors.white,
          ),
          onDismiss: onDismiss,
        );
}
