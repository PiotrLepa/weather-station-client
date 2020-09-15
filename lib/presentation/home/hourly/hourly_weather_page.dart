import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/home/hourly/widgets/hourly_weather_header.dart';
import 'package:weather_station/presentation/home/hourly/widgets/hourly_weather_initial.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/weather_chart.dart';

class HourlyWeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<HourlyWeatherBloc>(),
      child: Scaffold(
        body: BlocBuilder<HourlyWeatherBloc, HourlyWeatherState>(
          builder: (context, state) {
            return SafeArea(
              child: state.map(
                initial: (_) => Center(child: HourlyWeatherInitial()),
                renderCharts: (s) => _buildFakePage(context, s.weathers),
                renderError: (_) => Container(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFakePage(BuildContext context, KtList<Weather> weathers) {
    return ScrollConfiguration(
      behavior: DisableOverscrollGlowBehavior(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            HourlyWeatherHeader(day: weathers[0].date),
            SizedBox(height: 24),
            WeatherChart(weathers: weathers),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
