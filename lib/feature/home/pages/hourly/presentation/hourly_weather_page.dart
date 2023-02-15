import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station_client/di/dependency_injection.dart';
import 'package:weather_station_client/feature/home/pages/hourly/domain/bloc/hourly_weather_bloc.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/error/error_page.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/widgets/hourly_weather_initial.dart';
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
              appBar: AppBar(
                title: Text(context.strings.hourlyWeatherPageName),
                elevation: 4.0,
              ),
              body: state.map(
                loading: (_) =>
                    const Center(child: CircularProgressIndicator()),
                success: (data) => Center(
                  child: HourlyWeatherInitial(
                    availableDays: data.availableDays,
                    selectDateLoading: false,
                  ),
                ),
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
}
