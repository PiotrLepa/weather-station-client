import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/widgets/common/progress_button.dart';

class ErrorMessage extends StatelessWidget {
  final RKString message;
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
          SvgPicture.asset(
            'assets/icons/error.svg',
            width: 72,
            height: 72,
          ),
          SizedBox(height: 16),
          Text(
            context.translate(message),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Dimens.scale(19),
            ),
          ),
          SizedBox(height: 24),
          ProgressButton(
            key: buttonKey,
            text: KeyString('errorRetryButton'),
            onPressed: onRetry,
            loading: loading,
          ),
        ],
      ),
    );
  }
}
