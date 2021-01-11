import 'package:auto_route/auto_route_annotations.dart';
import 'package:weather_station/presentation/about_app/about_app_screen.dart';
import 'package:weather_station/presentation/configure_station/configure_station_screen.dart';
import 'package:weather_station/presentation/home/home_screen.dart';
import 'package:weather_station/presentation/license/details/license_details_screen.dart';
import 'package:weather_station/presentation/license/list/license_list_screen.dart';

@MaterialAutoRouter(
  generateNavigationHelperExtension: true,
  routes: <AutoRoute>[
    MaterialRoute<void>(page: HomeScreen, initial: true),
    MaterialRoute<void>(page: ConfigureStationScreen),
    MaterialRoute<void>(page: AboutAppScreen),
    MaterialRoute<void>(page: LicenseListScreen),
    MaterialRoute<void>(page: LicenseDetailsScreen),
  ],
)
class $AppRouter {}
