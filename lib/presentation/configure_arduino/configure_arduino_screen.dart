import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/domain/bloc/configure_arduino/configure_arduino_bloc.dart';
import 'package:weather_station/presentation/configure_arduino/widgets/configure_arduino_connecting_page.dart';

class ConfigureArduinoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ConfigureArduinoBloc>(),
      child: Builder(
        builder: (_) {
          return BlocBuilder<ConfigureArduinoBloc, ConfigureArduinoState>(
            builder: (context, state) {
              return ConfigureArduinoConnectingPage(
                  image: (state as Loading).image);
            },
          );
        },
      ),
    );
  }
}
