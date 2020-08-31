import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/widgets/loading_indicator.dart';
import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/hourly_weather/charts/temperature_chart.dart';

class HourlyWeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt.get<HourlyWeatherBloc>()..add(HourlyWeatherEvent.pageStarted()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<HourlyWeatherBloc, HourlyWeatherState>(
          builder: (context, state) {
            return state.map(
              initialLoading: (_) => Center(child: LoadingIndicator()),
              renderWeathers: (s) => _buildPage(s.weathers),
              renderError: (_) => Container(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPage(KtList<Weather> weathers) {
    return Container(
      child: TemperatureChart(
        temperatures: weathers.map((w) => w.temperature),
        dates: weathers.map((w) => w.date),
      ),
    );
  }
}
