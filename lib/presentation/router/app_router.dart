import 'package:auto_route/annotations.dart';
import 'package:weather_station_client/feature/home/parent/home_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute<void>(page: HomeScreen, initial: true),
  ],
)
class $AppRouter {}
