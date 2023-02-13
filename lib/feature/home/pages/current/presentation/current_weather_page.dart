import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station_client/di/dependency_injection.dart';
import 'package:weather_station_client/feature/home/pages/current/domain/bloc/current_weather_bloc.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/current_weather_content.dart';

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
            loading: (_) => const Center(child: CircularProgressIndicator()),
            success: (success) => CurrentWeatherContent(
              weather: success.weather,
              refreshLoading: false,
            ),
            error: (error) => Center(child: Text(error.message)),
          );
        }),
      ),
    );
  }
}
