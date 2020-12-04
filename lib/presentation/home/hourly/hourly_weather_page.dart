import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/core/presentation/widgets/error/error_page.dart';
import 'package:weather_station/core/presentation/widgets/loading/loading_indicator.dart';
import 'package:weather_station/domain/bloc/hourly_weather/hourly_weather_bloc.dart';
import 'package:weather_station/presentation/home/hourly/widgets/hourly_weather_header.dart';
import 'package:weather_station/presentation/home/hourly/widgets/hourly_weather_initial.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/weather_chart.dart';

class HourlyWeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      getIt.get<HourlyWeatherBloc>()
        ..add(ScreenStarted()),
      child: Scaffold(
        body: BlocBuilder<HourlyWeatherBloc, HourlyWeatherState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(elevation: _getAppBarElevation(state)),
              body: state.map(
                initialLoading: (s) =>
                const Center(
                  child: LoadingIndicator(),
                ),
                renderSelectDate: (s) =>
                    Center(
                      child: HourlyWeatherInitial(
                        selectDateLoading: s.selectDateLoading,
                      ),
                    ),
                renderCharts: (s) => _buildPage(context, s),
                renderError: (s) =>
                    ErrorPage(
                      message: s.message,
                      loading: s.loading,
                      onRetry: () {
                        context.read<HourlyWeatherBloc>().add(
                            const RetryPressed());
                      },
                    ),
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
            HourlyWeatherHeader(
              day: state.weathers[0].dateTime,
              changeDayLoading: state.changeDateLoading,
            ),
            const SizedBox(height: 24),
            WeatherChart(weathers: state.weathers),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  double _getAppBarElevation(HourlyWeatherState state) =>
      state.maybeMap(
        renderCharts: (_) => 0,
        orElse: () => 4,
      );
}
