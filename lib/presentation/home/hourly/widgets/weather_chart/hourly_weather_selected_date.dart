import 'package:flutter/material.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/date_time/date_time_formatter.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';

class HourlyWeatherSelectedDate extends StatelessWidget {
  final DateTime day;

  const HourlyWeatherSelectedDate({
    Key key,
    @required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.hourlyWeatherAppBarDay.get(context),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: scaleDimen(20),
            color: ThemeProvider.of(context).textColorLightInverted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          getIt<DateTimeFormatter>().format(
            day,
            DateTimeFormatter.defaultDatePattern,
          ),
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: scaleDimen(24),
            color: ThemeProvider.of(context).textColorInverted,
          ),
        ),
      ],
    );
  }
}
