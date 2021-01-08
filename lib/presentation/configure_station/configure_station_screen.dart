import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/domain/bloc/configure_station/configure_station_bloc.dart';
import 'package:weather_station/presentation/configure_station/widgets/configure_station_page.dart';

class ConfigureStationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ConfigureStationBloc>()..add(const ScreenStarted()),
      child: Scaffold(
        appBar: AppBar(),
        body: ConfigureStationPage(),
      ),
    );
  }
}
