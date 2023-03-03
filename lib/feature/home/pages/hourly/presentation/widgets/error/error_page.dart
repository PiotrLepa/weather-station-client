import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/error/error_message.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final bool isLoading;
  final Key? buttonKey;

  const ErrorPage({
    Key? key,
    required this.message,
    required this.isLoading,
    this.onRetry,
    this.buttonKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Center(
        child: ErrorMessage(
          message: message,
          onRetry: onRetry,
          isLoading: isLoading,
          buttonKey: buttonKey,
        ),
      ),
    );
  }
}
