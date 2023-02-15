import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/progress_button.dart';
import 'package:weather_station_client/gen/assets.gen.dart';
import 'package:weather_station_client/presentation/extensions.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final bool isLoading;
  final Key? buttonKey;

  const ErrorMessage({
    Key? key,
    required this.message,
    required this.onRetry,
    required this.isLoading,
    this.buttonKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.icons.error.svg(
            width: 72,
            height: 72,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 24),
          ProgressButton(
            key: buttonKey,
            text: context.strings.retryButton,
            onPressed: onRetry,
            loading: isLoading,
          ),
        ],
      ),
    );
  }
}
