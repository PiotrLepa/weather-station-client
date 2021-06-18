import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/domain/bloc/error_logger_bloc_observer.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/presentation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureInjection();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = getIt<ErrorLoggerBlocObserver>();
  runApp(App());
}
