import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_bloc.dart';
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
            return Scaffold(
              appBar: AppBar(elevation: 0),
              body: state.map(
                initial: (s) => Center(
                  child: HourlyWeatherInitial(
                    selectDateLoading: s.selectDateLoading,
                  ),
                ),
                renderCharts: (s) => _buildPage(context, s),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context, RenderCharts state) {
    return ScrollConfiguration(
      behavior: DisableOverscrollGlowBehavior(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: HourlyWeatherHeader(
                day: state.weathers[0].date,
                changeDayLoading: state.changeDateLoading,
              ),
            ),
            SizedBox(height: 24),
            WeatherChart(weathers: state.weathers),
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
