import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station_client/di/dependency_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencyInjection() async => getIt.init();
