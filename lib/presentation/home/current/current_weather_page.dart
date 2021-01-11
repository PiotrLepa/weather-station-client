import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/widgets/error/error_page.dart';
import 'package:weather_station/core/presentation/widgets/loading/loading_indicator.dart';
import 'package:weather_station/domain/bloc/current_weather/current_weather_bloc.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_content.dart';

class CurrentWeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<CurrentWeatherBloc>()..add(const PageStarted()),
      child: Scaffold(
        body: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
          builder: (context, state) {
            return state.maybeMap(
              initialLoading: (_) => _wrapWithScaffold(
                context,
                const Center(child: LoadingIndicator()),
              ),
              renderWeather: (s) => CurrentWeatherContent(
                weather: s.weather,
                refreshLoading: s.refreshLoading,
              ),
              renderError: (s) => _wrapWithScaffold(
                context,
                ErrorPage(
                  message: s.message,
                  loading: s.loading,
                  onRetry: () {
                    context
                        .read<CurrentWeatherBloc>()
                        .add(const RetryPressed());
                  },
                ),
              ),
              orElse: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }

  Widget _wrapWithScaffold(BuildContext context, Widget child) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.weatherPageAppBarTitle.get(context)),
      ),
      body: child,
    );
  }
}
