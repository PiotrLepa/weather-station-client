import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/core/presentation/widgets/loading_indicator.dart';
import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/hourly_weather/hourly_weather_left_titles.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/chart_constants.dart';
import 'package:weather_station/presentation/hourly_weather/weather_chart/weather_chart.dart';

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
              renderWeathers: (s) => _buildPage(context, s.weathers),
              renderError: (_) => Container(),
            );
          },
        ),
      ),
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
