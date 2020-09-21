import 'package:flutter/material.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/presentation/widgets/error/error_message.dart';

class ErrorPage extends StatelessWidget {
  final RKString message;
  final VoidCallback onRetry;
  final Key buttonKey;

  const ErrorPage({
    Key key,
    @required this.message,
    @required this.onRetry,
    this.buttonKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: ErrorMessage(
          message: message,
          onRetry: onRetry,
          buttonKey: buttonKey,
        ),
      ),
    );
  }
}
