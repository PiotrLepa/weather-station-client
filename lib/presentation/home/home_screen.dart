import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/domain/bloc/home/home_bloc.dart';
import 'package:weather_station/gen/assets.gen.dart';
import 'package:weather_station/presentation/home/current/current_weather_page.dart';
import 'package:weather_station/presentation/home/hourly/hourly_weather_page.dart';

class HomeScreen extends StatelessWidget {
  final _pages = [
    CurrentWeatherPage(),
    HourlyWeatherPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          body: IndexedStack(
            index: state.index,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _buildBottomNavItems(context),
            currentIndex: state.index,
            selectedItemColor: ThemeProvider.of(context).primaryColor,
            onTap: (index) => context
                .bloc<HomeBloc>()
                .add(HomeEvent.onBottomNavigationTapped(index)),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavItems(BuildContext context) => [
        BottomNavigationBarItem(
          title: Text(context.translateKey('tabTitleCurrent')),
          icon: _getBottomNavIcon(
            context,
            Assets.icons.currentWeather.path,
            isActive: false,
          ),
          activeIcon: _getBottomNavIcon(
            context,
            Assets.icons.currentWeather.path,
            isActive: true,
          ),
        ),
        BottomNavigationBarItem(
          title: Text(context.translateKey('tabTitleHourly')),
          icon: _getBottomNavIcon(
            context,
            Assets.icons.hourlyWeather.path,
            isActive: false,
          ),
          activeIcon: _getBottomNavIcon(
            context,
            Assets.icons.hourlyWeather.path,
            isActive: true,
          ),
        ),
      ];

  SvgPicture _getBottomNavIcon(
    BuildContext context,
    String path, {
    @required bool isActive,
  }) {
    return SvgPicture.asset(
      path,
      width: 24,
      height: 24,
      color: isActive
          ? ThemeProvider.of(context).primaryColor
          : ThemeProvider.of(context).textColor,
    );
  }
}
