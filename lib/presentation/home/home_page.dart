import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/core/presentation/widgets/common/fill_empty_space_sliver.dart';
import 'package:weather_station/core/presentation/widgets/loading_indicator.dart';
import 'package:weather_station/domain/bloc/home/home_bloc.dart';
import 'package:weather_station/domain/entity/weather/weather.dart';
import 'package:weather_station/presentation/home/widgets/home_app_bar.dart';
import 'package:weather_station/presentation/home/widgets/home_app_bar_corners.dart';
import 'package:weather_station/presentation/home/widgets/home_list.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<HomeBloc>()..add(HomeEvent.pageStarted()),
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return state.map(
              initialLoading: (_) => Center(child: LoadingIndicator()),
              renderWeather: (s) => _buildPage(s.weather),
              renderError: (_) => Container(),
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
          HomeAppBar(
            height: appBarHeight,
            expandedHeight: appBarExpandedHeight,
            location: weather.location,
            lastUpdateTime: weather.date,
          ),
          HomeAppBarCorners(),
          HomeCards(weather: weather),
          FillEmptySpaceSliver(
            minHeaderHeight: appBarHeight,
            maxHeaderHeight: appBarExpandedHeight,
          ),
        ],
      ),
    );
  }
}
