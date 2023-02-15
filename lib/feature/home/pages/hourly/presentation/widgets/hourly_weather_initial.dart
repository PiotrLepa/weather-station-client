import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/progress_button.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/bloc/hourly_weather_bloc.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/hourly_weather_day_picker.dart';
import 'package:weather_station_client/gen/assets.gen.dart';
import 'package:weather_station_client/presentation/extensions.dart';

class HourlyWeatherInitial extends StatelessWidget {
  final List<DateTime> availableDays;
  final bool selectDateLoading;

  const HourlyWeatherInitial({
    Key? key,
    required this.availableDays,
    required this.selectDateLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.icons.calendar.svg(
            width: 60,
            height: 60,
          ),
          const SizedBox(height: 24),
          Text(
            context.strings.hourlyWeatherInitialDescription,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ProgressButton(
              loading: selectDateLoading,
              text: context.strings.hourlyWeatherInitialButton,
              onPressed: () => _showDatePicker(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    await showHourlyWeatherDayPicker(
      context,
      availableDays,
      (selectedDate) {
        context.read<HourlyWeatherBloc>().add(DateSelected(selectedDate));
      },
    );
  }
}
