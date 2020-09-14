import 'package:auto_route/auto_route_annotations.dart';
import 'package:weather_station/presentation/home/current/current_weather_page.dart';
import 'package:weather_station/presentation/home/hourly/hourly_weather_page.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute(page: CurrentWeatherPage, initial: true),
    MaterialRoute(page: HourlyWeatherPage),
  ],
)
class $Router {}
