import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station_client/di/dependency_injection.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/bloc/current_weather_bloc.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/current_weather_content.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/error/error_page.dart';
import 'package:weather_station_client/presentation/extensions.dart';

class CurrentWeatherPage extends StatelessWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CurrentWeatherBloc>()..add(const ScreenStarted()),
      child: Scaffold(
        body: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
            builder: (BuildContext context, CurrentWeatherState state) {
          return state.map(
            loading: (_) => _wrapWithAppBar(
              context: context,
              child: const Center(child: CircularProgressIndicator()),
            ),
            success: (data) => CurrentWeatherContent(
              weather: data.weather,
              refreshLoading: false,
            ),
            error: (error) => _wrapWithAppBar(
              context: context,
              child: ErrorPage(
                isLoading: false,
                message: context.strings.genericErrorAutoRefreshMessage,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _wrapWithAppBar({
    required BuildContext context,
    required Widget child,
  }) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.currentWeatherPageAppBarTitleLong),
      ),
      body: child,
    );
  }
}
