import 'package:flutter/material.dart';
import 'package:weather_station_client/di/dependency_injection.dart';
import 'package:weather_station_client/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencyInjection();
  runApp(App());
}
