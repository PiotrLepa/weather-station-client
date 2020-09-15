import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/home/hourly/widgets/hourly_weather_app_bar.dart';
import 'package:weather_station/presentation/home/hourly/widgets/hourly_weather_initial.dart';
import 'package:weather_station/presentation/home/hourly/widgets/hourly_weather_left_titles.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';
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
    return CustomScrollView(
      slivers: [
        HourlyWeatherAppBar(day: weathers[0].date),
        SliverList(
          delegate: SliverChildListDelegate([
            // HourlyWeatherSelectedDate(day: weathers[0].date),
            // SizedBox(height: 48),
            SizedBox(height: 24),
            _buildPage(context, weathers),
            SizedBox(height: 48),
            _buildPage(context, weathers),
            SizedBox(height: 48),
          ]),
        ),
      ],
    );
  }

  Widget _buildPage(BuildContext context, KtList<Weather> weathers) {
    return ScrollConfiguration(
      behavior: DisableOverscrollGlowBehavior(),
      child: SizedBox(
        height: ChartConstants.heights.sum(),
        child: CustomScrollView(
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverPersistentHeader(
              floating: true,
              delegate: HourlyWeatherLeftTitles(
                leftTitles: ChartConstants.leftTitles
                    .map((title) => context.translate(title)),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [WeatherChart(weathers: weathers)],
              ),
            )
          ],
        ),
      ),
    );
  }
}
