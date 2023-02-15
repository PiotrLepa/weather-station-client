import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/current_weather_page.dart';
import 'package:weather_station_client/feature/home/pages/hourly/presentation/hourly_weather_page.dart';
import 'package:weather_station_client/feature/home/pages/settings/settings_page.dart';
import 'package:weather_station_client/feature/home/parent/bloc/home_pages_bloc.dart';
import 'package:weather_station_client/gen/assets.gen.dart';
import 'package:weather_station_client/presentation/extensions.dart';
import 'package:weather_station_client/presentation/theme/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  final _pages = [
    const CurrentWeatherPage(),
    const HourlyWeatherPage(),
    const SettingsPage(),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePagesBloc, HomePagesState>(
      builder: (BuildContext context, HomePagesState state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentPageIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _buildBottomNavItems(context),
            currentIndex: state.currentPageIndex,
            selectedItemColor: ThemeProvider.of(context).primaryColor,
            onTap: (index) => context
                .read<HomePagesBloc>()
                .add(BottomNavigationClicked(index)),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavItems(BuildContext context) => [
        _getBottomNavItem(
          context,
          context.strings.currentWeatherPageName,
          Assets.icons.currentWeather,
        ),
        _getBottomNavItem(
          context,
          context.strings.hourlyWeatherPageName,
          Assets.icons.hourlyWeather,
        ),
        _getBottomNavItem(
          context,
          context.strings.settingsPageName,
          Assets.icons.settings,
        ),
      ];

  BottomNavigationBarItem _getBottomNavItem(
    BuildContext context,
    String title,
    SvgGenImage icon,
  ) {
    return BottomNavigationBarItem(
      label: title,
      icon: _getBottomNavIcon(
        context,
        icon.path,
        isActive: false,
      ),
      activeIcon: _getBottomNavIcon(
        context,
        icon.path,
        isActive: true,
      ),
    );
  }

  SvgPicture _getBottomNavIcon(
    BuildContext context,
    String path, {
    required bool isActive,
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
