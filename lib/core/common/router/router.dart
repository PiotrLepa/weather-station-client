import 'package:auto_route/auto_route_annotations.dart';
import 'package:weather_station/presentation/home/home_screen.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(page: HomeScreen, initial: true),
  ],
)
class $Router {}
