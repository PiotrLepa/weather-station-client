import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/util/plural_util.dart';

@lazySingleton
class UpdateTimeFormatter {
  final PluralUtil _pluralUtil;

  UpdateTimeFormatter(this._pluralUtil);

  String format(BuildContext context, DateTime lastUpdateTime) {
    final difference = DateTime.now().difference(lastUpdateTime);
    const agoLabel = "temu";

    if (difference.inDays >= 1) {
      return "Ponad dzień $agoLabel";
    } else if (difference.inHours >= 1) {
      final hoursLabel = _getHoursLabel(difference.inHours);
      return '${difference.inHours} $hoursLabel $agoLabel';
    } else if (difference.inMinutes == 0) {
      return "Teraz";
    } else {
      final minutesLabel = _getMinutesLabel(difference.inMinutes);
      return '${difference.inMinutes} $minutesLabel $agoLabel';
    }
  }

  String _getMinutesLabel(int minutes) {
    return _pluralUtil.applyPlurals(
      quantity: minutes,
      one: "minutę",
      few: "minuty",
      many: "minut",
    );
  }

  String _getHoursLabel(int hours) {
    return _pluralUtil.applyPlurals(
      quantity: hours,
      one: "godzinę",
      few: "godziny",
      many: "godzin",
    );
  }
}
