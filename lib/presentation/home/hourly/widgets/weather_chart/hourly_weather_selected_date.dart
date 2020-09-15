import 'package:flutter/material.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/date_time/date_time_formatter.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';

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
          'Dane z dnia',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: Dimens.scale(20),
            color: ThemeProvider.of(context).textColorLightInverted,
          ),
        ),
        SizedBox(height: 4),
        Text(
          getIt<DateTimeFormatter>().format(
            day,
            DateTimeFormatter.DEFAULT_DATE_PATTERN,
          ),
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: Dimens.scale(24),
            color: ThemeProvider.of(context).textColorInverted,
          ),
        ),
      ],
    );
  }
}
