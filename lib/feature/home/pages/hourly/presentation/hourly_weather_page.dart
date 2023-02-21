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

class HourlyWeatherPage extends StatelessWidget {
  const HourlyWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<HourlyWeatherBloc>()..add(const ScreenStarted()),
      child: Scaffold(
        body: BlocBuilder<HourlyWeatherBloc, HourlyWeatherState>(
          builder: (context, state) {
            return Scaffold(
              appBar: _buildAppBar(
                context,
                state is Success && state.hourlyWeather != null,
              ),
              body: state.map(
                loading: (_) =>
                    const Center(child: CircularProgressIndicator()),
                success: (data) {
                  if (data.hourlyWeather != null) {
                    return _buildHourlyWeatherPage(
                      context,
                      data.availableDays,
                      data.hourlyWeather!,
                    );
                  } else {
                    return Center(
                      child: HourlyWeatherInitial(
                        availableDays: data.availableDays,
                        selectDateLoading: false,
                      ),
                    );
                  }
                },
                error: (data) => ErrorPage(
                  isLoading: false,
                  message: data.message,
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

  AppBar _buildAppBar(
    BuildContext context,
    bool chartsVisible,
  ) {
    final title = chartsVisible ? null : context.strings.hourlyWeatherPageName;
    final elevation = chartsVisible ? 0.0 : 4.0;

    return AppBar(
      title: title != null ? Text(title) : null,
      elevation: elevation,
    );
  }

  Widget _buildHourlyWeatherPage(
    BuildContext context,
    List<DateTime> availableDays,
    List<Weather> weathers,
  ) {
    return ScrollConfiguration(
      behavior: DisableOverscrollGlowBehavior(),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            HourlyWeatherHeader(
              day: weathers.first.timestamp,
              availableDays: availableDays,
              changeDayLoading: false, // TODO
            ),
            const SizedBox(height: 24),
            WeatherChart(weathers: weathers),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
