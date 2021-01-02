import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/core/presentation/widgets/common/progress_button.dart';
import 'package:weather_station/gen/assets.gen.dart';

class ErrorMessage extends StatelessWidget {
  final PlainLocalizedString message;
  final VoidCallback onRetry;
  final bool loading;
  final Key buttonKey;

  const ErrorMessage({
    Key key,
    @required this.message,
    @required this.onRetry,
    @required this.loading,
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
            message.get(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: scaleDimen(19),
            ),
          ),
          const SizedBox(height: 24),
          ProgressButton(
            key: buttonKey,
            text: Strings.errorRetryButton,
            onPressed: onRetry,
            loading: loading,
          ),
        ],
      ),
    );
  }
}
