import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/core/presentation/widgets/loading/loading_indicator.dart';

class ConnectingToWifiDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: [
          const SizedBox(width: 12),
          const LoadingIndicator(),
          const SizedBox(width: 24),
          Text(
            Strings.connecting.get(context),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: scaleDimen(16),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
