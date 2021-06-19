import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/widgets/common/progress_button.dart';
import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_station/gen/assets.gen.dart';
import 'package:weather_station/presentation/home/hourly/utils/hourly_weather_day_picker.dart';

class HourlyWeatherInitial extends StatelessWidget {
  final KtList<DateTime> availableDays;
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
            Strings.hourlyWeatherInitialDescription.get(context),
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
              text: Strings.hourlyWeatherInitialButton,
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
        context.read<HourlyWeatherBloc>().add(LoadPressed(selectedDate));
      },
    );
  }
}
