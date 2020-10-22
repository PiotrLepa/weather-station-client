import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/injection/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection() async => $initGetIt(getIt);
