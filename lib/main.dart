import 'package:flutter/material.dart';
import 'package:weather_station_client/di/dependency_injection.dart';
import 'package:weather_station_client/presentation/app.dart';

Future<void> main() async {
  await configureDependencyInjection();
  runApp(App());
}
