import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/presentation/extensions.dart';

@lazySingleton
class UpdateTimeFormatter {

  String format(BuildContext context, DateTime lastUpdateTime) {
    final difference =
        Duration(minutes: 0); //DateTime.now().difference(lastUpdateTime);
    final agoLabel = context.strings.agoLabel;

    if (difference.inDays >= 1) {
      return "${context.strings.updateTimeOverDay} $agoLabel";
    } else if (difference.inHours >= 1) {
      final hoursLabel = context.strings.hours(difference.inHours);
      return '${difference.inHours} $hoursLabel $agoLabel';
    } else if (difference.inMinutes == 0) {
      return context.strings.updateTimeNow;
    } else {
      final minutesLabel = context.strings.minutes(difference.inMinutes);
      return '${difference.inMinutes} $minutesLabel $agoLabel';
    }
  }

}
