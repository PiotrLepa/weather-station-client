import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/util/plural_util.dart';

@lazySingleton
class UpdateTimeFormatter {
  final PluralUtil _pluralUtil;

  UpdateTimeFormatter(this._pluralUtil);

  String format(BuildContext context, DateTime lastUpdateTime) {
    final difference = DateTime.now().difference(lastUpdateTime);
    final agoString = Strings.updateTimeAgo.get(context);

    if (difference.inDays >= 1) {
      return '${Strings.updateTimeMoreThanDay.get(context)} $agoString';
    } else if (difference.inHours >= 1) {
      final hoursForm = _getHoursForm(difference.inHours).get(context);
      return '${difference.inHours} $hoursForm $agoString';
    } else if (difference.inMinutes == 0) {
      return Strings.updateTimeNow.get(context);
    } else {
      final minutesForm = _getMinutesForm(difference.inMinutes).get(context);
      return '${difference.inMinutes} $minutesForm $agoString';
    }
  }

  PlainLocalizedString _getMinutesForm(int minutes) {
    return _pluralUtil.applyPlurals(
      quantity: minutes,
      one: Strings.pluralMinutesOne,
      few: Strings.pluralMinutesFew,
      many: Strings.pluralMinutesMany,
    );
  }

  PlainLocalizedString _getHoursForm(int hours) {
    return _pluralUtil.applyPlurals(
      quantity: hours,
      one: Strings.pluralHoursOne,
      few: Strings.pluralHoursFew,
      many: Strings.pluralHoursMany,
    );
  }
}
