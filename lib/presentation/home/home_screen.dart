import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            items: buildBottomNavItems(context),
            currentIndex: state.index,
            selectedItemColor: Theme.of(context).primaryColor,
            onTap: (index) => context
                .bloc<HomeBloc>()
                .add(HomeEvent.onBottomNavigationTapped(index)),
          ),
        );
      },
    );
  }

  List<BottomNavigationBarItem> buildBottomNavItems(BuildContext context) => [
        BottomNavigationBarItem(
          icon: Icon(Icons.gamepad),
          title: Text('Aktualna'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          title: Text("Godzinowa"),
        ),
      ];
}
