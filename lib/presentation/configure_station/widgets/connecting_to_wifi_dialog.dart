import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/widgets/loading/loading_indicator.dart';

class ConnectingToWifiDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        children: const [
          SizedBox(width: 12),
          LoadingIndicator(),
          SizedBox(width: 24),
          Text('Łączenie...'),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}
