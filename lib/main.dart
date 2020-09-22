import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/domain/bloc/error_logger_bloc_observer.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection(Env.dev);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = ErrorLoggerBlocObserver();
  runApp(App());
}
