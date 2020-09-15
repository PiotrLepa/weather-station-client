import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/core/presentation/widgets/common/progress_button.dart';
import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_bloc.dart';

class HourlyWeatherInitial extends StatelessWidget {
  final _selectDateButtonKey = GlobalKey<ProgressButtonState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/calendar.svg',
            width: 60,
            height: 60,
          ),
          SizedBox(height: 24),
          Text(
            'Wybierz datę, aby zobaczyć szczegółowe dane',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ProgressButton(
              key: _selectDateButtonKey,
              text: 'Wybierz',
              onPressed: () => _showDatePicker(context),
            ),
          ),
        ],
      ),
    );
  }

  Future _showDatePicker(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 06, 01),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      _selectDateButtonKey.currentState.show();
      context
          .bloc<HourlyWeatherBloc>()
          .add(HourlyWeatherEvent.onLoadClicked(selectedDate));
    }
  }
}
