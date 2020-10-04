import 'package:auto_route/auto_route_annotations.dart';
import 'package:weather_station/presentation/configure_station/configure_station_screen.dart';
import 'package:weather_station/presentation/home/home_screen.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute<void>(page: HomeScreen, initial: true),
    MaterialRoute<void>(page: ConfigureStationScreen),
  ],
)
class $RouterConfig {}
