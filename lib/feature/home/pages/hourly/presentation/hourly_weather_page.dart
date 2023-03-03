import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station_client/di/dependency_injection.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/model/weather.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/disable_overscroll_glow_behavior.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/bloc/hourly_weather_bloc.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/error/error_page.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/hourly_weather_header.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/hourly_weather_initial.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/weather_chart/weather_chart.dart';
import 'package:weather_station_client/presentation/extensions.dart';
import 'package:weather_station_client/presentation/theme/theme_provider.dart';

class HourlyWeatherPage extends StatelessWidget {
  const HourlyWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<HourlyWeatherBloc>()..add(const ScreenStarted()),
      child: Scaffold(
        body: BlocConsumer<HourlyWeatherBloc, HourlyWeatherState>(
          listener: (oldState, newState) {
            newState.maybeMap(
              availableDaysFetched: (data) {
                if (data.isError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.strings.genericErrorRetryMessage),
                      backgroundColor: ThemeProvider.of(context).errorColor,
                    ),
                  );
                }
              },
              orElse: () => {},
            );
          },
          builder: (context, state) {
            return Scaffold(
              appBar: _buildAppBar(
                context: context,
                chartsVisible: state is HourlyWeatherFetched,
              ),
              body: state.map(
                initialLoading: (_) =>
                    const Center(child: CircularProgressIndicator()),
                availableDaysFetched: (data) => Center(
                  child: HourlyWeatherInitial(
                    selectDateLoading: data.isLoading,
                    availableDays: data.availableDays,
                  ),
                ),
                hourlyWeatherFetched: (data) => _buildHourlyWeatherPage(
                  context: context,
                  isLoading: data.isLoading,
                  availableDays: data.availableDays,
                  hourlyWeather: data.hourlyWeather,
                ),
                initialError: (data) => ErrorPage(
                  isLoading: false,
                  message: context.strings.genericErrorRetryWithNewLineMessage,
                  onRetry: () {
                    context.read<HourlyWeatherBloc>().add(const RetryPressed());
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar({
    required BuildContext context,
    required bool chartsVisible,
  }) {
    final title = chartsVisible ? null : context.strings.hourlyWeatherPageName;
    final elevation = chartsVisible ? 0.0 : 4.0;

    return AppBar(
      title: title != null ? Text(title) : null,
      elevation: elevation,
    );
  }

  Widget _buildHourlyWeatherPage({
    required BuildContext context,
    required bool isLoading,
    required List<DateTime> availableDays,
    required List<Weather> hourlyWeather,
  }) {
    return ScrollConfiguration(
      behavior: DisableOverscrollGlowBehavior(),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            HourlyWeatherHeader(
              changeDayLoading: isLoading,
              day: hourlyWeather.first.timestamp,
              availableDays: availableDays,
            ),
            const SizedBox(height: 24),
            WeatherChart(weathers: hourlyWeather),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
