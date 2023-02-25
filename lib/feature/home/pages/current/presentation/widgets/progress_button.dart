import 'package:flutter/material.dart';
import 'package:weather_station_client/presentation/extensions.dart';
import 'package:weather_station_client/presentation/theme/theme_provider.dart';

class ProgressButton extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final bool loading;
  final VoidCallback onPressed;

  const ProgressButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.loading,
    this.textStyle,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (!loading) {
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 16),
          Text(
            loading ? context.strings.progressButtonLoading : text,
            style: textStyle,
          ),
          const SizedBox(width: 16),
          Visibility(
            visible: loading,
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getProgressColor(context),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _getProgressColor(BuildContext context) {
    return textStyle?.color ??
        Theme.of(context)
            .elevatedButtonTheme
            .style
            ?.textStyle
            ?.resolve({MaterialState.focused})?.color ??
        ThemeProvider.of(context).textColorInverted;
  }
}
