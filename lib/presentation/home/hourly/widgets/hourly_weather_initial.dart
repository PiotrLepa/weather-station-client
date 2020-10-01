import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/common/progress_button.dart';
import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_cubit.dart';
import 'package:weather_station/gen/assets.gen.dart';

class HourlyWeatherInitial extends StatelessWidget {
  final bool selectDateLoading;

  const HourlyWeatherInitial({
    Key key,
    @required this.selectDateLoading,
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
              textStyle: TextStyle(
                color: ThemeProvider.of(context).textColorInverted,
              ),
              onPressed: () => _showDatePicker(context),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 06),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      context
          .bloc<HourlyWeatherBloc>()
          .add(HourlyWeatherEvent.loadPressed(selectedDate));
    }
  }
}
