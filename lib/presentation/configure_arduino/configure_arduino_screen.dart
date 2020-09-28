import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/domain/bloc/configure_arduino/configure_arduino_bloc.dart';
import 'package:weather_station/presentation/configure_arduino/widgets/configure_arduino_connecting.dart';
import 'package:weather_station/presentation/configure_arduino/widgets/configure_arduino_wifi_inputs.dart';

class ConfigureArduinoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ConfigureArduinoBloc>()
        ..add(const ConfigureArduinoEvent.onScreenStarted()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ConfigureArduinoBloc, ConfigureArduinoState>(
          builder: (context, state) {
            return state.map(
              loading: (s) => ConfigureArduinoConnecting(image: s.image),
              renderWifiInputs: (s) => ConfigureArduinoWifiInputs(),
            );
          },
        ),
      ),
    );
  }
}
