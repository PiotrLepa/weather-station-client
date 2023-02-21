import 'package:flutter/material.dart';
import 'package:weather_station_client/di/dependency_injection.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/date_time_formatter.dart';
import 'package:weather_station_client/presentation/extensions.dart';
import 'package:weather_station_client/presentation/theme/theme_provider.dart';

class HourlyWeatherSelectedDate extends StatelessWidget {
  final DateTime day;

  const HourlyWeatherSelectedDate({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.hourlyWeatherAppBarDay,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
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
            fontSize: 24,
            color: ThemeProvider.of(context).textColorInverted,
          ),
        ),
      ],
    );
  }
}
