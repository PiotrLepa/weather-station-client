import 'package:flutter/material.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/half_bottom_circle_shape_painter.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/progress_button.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/hourly_weather_day_picker.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/hourly_weather_selected_date.dart';
import 'package:weather_station_client/gen/assets.gen.dart';
import 'package:weather_station_client/presentation/extensions.dart';
import 'package:weather_station_client/presentation/theme/theme_provider.dart';

class HourlyWeatherHeader extends StatelessWidget {
  final DateTime day;
  final List<DateTime> availableDays;
  final bool changeDayLoading;

  const HourlyWeatherHeader({
    Key? key,
    required this.day,
    required this.availableDays,
    required this.changeDayLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const padding = 24.0;

    return Container(
      color: ThemeProvider.of(context).backgroundColor,
      child: CustomPaint(
        painter: HalfBottomCircleShapePainter(
          color: ThemeProvider.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(padding, 0, padding, padding),
          child: Column(
            children: [
              Row(
                children: [
                  HourlyWeatherSelectedDate(day: day),
                  const SizedBox(width: padding),
                  Expanded(
                    child: Assets.icons.weatherGraph.svg(
                      width: 72,
                      height: 72,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                child: ProgressButton(
                  text: context.strings.hourlyWeatherChangeDay,
                  loading: changeDayLoading,
                  backgroundColor: Colors.white,
                  textStyle: TextStyle(
                    color: ThemeProvider.of(context).textColor,
                  ),
                  onPressed: () => _showDatePicker(context),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    await showHourlyWeatherDayPicker(
      context,
      availableDays,
      (selectedDate) {
        // context.read<HourlyWeatherBloc>().add(ChangeDatePressed(selectedDate));
      },
      initialDate: day,
    );
  }
}
