import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/core/presentation/widgets/common/fill_empty_space_sliver.dart';
import 'package:weather_station/core/presentation/widgets/error/error_page.dart';
import 'package:weather_station/core/presentation/widgets/loading_indicator.dart';
import 'package:weather_station/domain/bloc/current_weather/current_weather_bloc.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_app_bar.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_app_bar_corners.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_cards.dart';

class CurrentWeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<CurrentWeatherBloc>()
        ..add(const CurrentWeatherEvent.pageStarted()),
      child: Scaffold(
        body: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
          builder: (context, state) {
            return state.maybeMap(
              initialLoading: (_) => const Center(child: LoadingIndicator()),
              renderWeather: (s) => _buildPage(s),
              renderError: (s) => ErrorPage(
                message: s.message,
                loading: s.loading,
                onRetry: () {
                  context
                      .bloc<CurrentWeatherBloc>()
                      .add(const CurrentWeatherEvent.retryPressed());
                },
              ),
              orElse: () => Container(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPage(RenderWeather state) {
    const appBarHeight = kToolbarHeight;
    const appBarExpandedHeight = 300.0;
    return ScrollConfiguration(
      behavior: DisableOverscrollGlowBehavior(),
      child: CustomScrollView(
        slivers: [
          CurrentWeatherAppBar(
            height: appBarHeight,
            expandedHeight: appBarExpandedHeight,
            location: state.weather.location,
            lastUpdateTime: state.weather.date,
            refreshLoading: state.refreshLoading,
          ),
          CurrentWeatherAppBarCorners(),
          CurrentWeatherCards(weather: state.weather),
          const FillEmptySpaceSliver(
            minHeaderHeight: appBarHeight,
            maxHeaderHeight: appBarExpandedHeight,
          ),
        ],
      ),
    );
  }
}
