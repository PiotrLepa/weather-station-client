import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/injection/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection(String environment) async =>
    $initGetIt(getIt, environment: environment);

abstract class Env {
  static const dev = 'dev';
  static const prod = 'prod';
}
