import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/domain/bloc/home/home_bloc.dart';
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

  List<BottomNavigationBarItem> _buildBottomNavItems(BuildContext context) =>
      [
        BottomNavigationBarItem(
          title: Text('Aktualna'),
          icon: _getBottomNavIcon(
            context,
            'assets/icons/current_weather.svg',
            isActive: false,
          ),
          activeIcon: _getBottomNavIcon(
            context,
            'assets/icons/current_weather.svg',
            isActive: true,
          ),
        ),
        BottomNavigationBarItem(
          title: Text("Godzinowa"),
          icon: _getBottomNavIcon(
            context,
            'assets/icons/hourly_weather.svg',
            isActive: false,
          ),
          activeIcon: _getBottomNavIcon(
            context,
            'assets/icons/hourly_weather.svg',
            isActive: true,
          ),
        ),
      ];

  SvgPicture _getBottomNavIcon(BuildContext context,
      String path, {
        @required isActive,
      }) {
    return SvgPicture.asset(
      path,
      width: 24,
      height: 24,
      color: isActive
          ? ThemeProvider
          .of(context)
          .primaryColor
          : ThemeProvider
          .of(context)
          .textColor,
    );
  }
}
