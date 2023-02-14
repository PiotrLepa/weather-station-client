import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/presentation/extensions.dart';

@lazySingleton
class UpdateTimeFormatter {
  String format(BuildContext context, DateTime lastUpdateTime) {
    final difference = DateTime.now().difference(lastUpdateTime);

    if (difference.inDays >= 1) {
      return context.strings.updateTimeOverDayAgo;
    } else if (difference.inHours >= 1) {
      return context.strings.hoursAgo(difference.inHours);
    } else if (difference.inMinutes >= 1) {
      return context.strings.minutesAgo(difference.inMinutes);
    } else {
      return context.strings.updateTimeNow;
    }
  }
}
