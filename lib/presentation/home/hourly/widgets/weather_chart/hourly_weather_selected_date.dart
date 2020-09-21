import 'package:flutter/material.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
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
          context.translateKey('hourlyWeatherAppBarDay'),
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
            DateTimeFormatter.defaultDatePattern,
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
