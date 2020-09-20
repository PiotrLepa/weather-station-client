import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/core/presentation/widgets/common/fill_empty_space_sliver.dart';
import 'package:weather_station/core/presentation/widgets/loading_indicator.dart';
import 'package:weather_station/domain/bloc/current_weather/current_weather_bloc.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_app_bar.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_app_bar_corners.dart';
import 'package:weather_station/presentation/home/current/widgets/current_weather_cards.dart';

class CurrentWeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<CurrentWeatherBloc>()
        ..add(CurrentWeatherEvent.pageStarted()),
      child: Scaffold(
        body: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
          buildWhen: (oldState, newState) => newState is! DoNothing,
          builder: (context, state) {
            return state.maybeMap(
              initialLoading: (_) => Center(child: LoadingIndicator()),
              renderWeather: (s) => _buildPage(s.weather),
              renderError: (_) => Container(),
              orElse: () => Container(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPage(Weather weather) {
    final appBarHeight = kToolbarHeight;
    final appBarExpandedHeight = 300.0;
    return ScrollConfiguration(
      behavior: DisableOverscrollGlowBehavior(),
      child: CustomScrollView(
        slivers: [
          CurrentWeatherAppBar(
            height: appBarHeight,
            expandedHeight: appBarExpandedHeight,
            location: weather.location,
            lastUpdateTime: weather.date,
          ),
          CurrentWeatherAppBarCorners(),
          CurrentWeatherCards(weather: weather),
          FillEmptySpaceSliver(
            minHeaderHeight: appBarHeight,
            maxHeaderHeight: appBarExpandedHeight,
          ),
        ],
      ),
    );
  }
}
