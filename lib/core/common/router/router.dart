import 'package:auto_route/auto_route_annotations.dart';
import 'package:weather_station/presentation/home/home_page.dart';
import 'package:weather_station/presentation/hourly_weather/hourly_weather_page.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(page: HomePage, initial: true),
    MaterialRoute(page: HourlyWeatherPage),
  ],
)
class $Router {}
