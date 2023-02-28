import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_station_client/di/dependency_injection.dart';
import 'package:weather_station_client/feature/home/parent/bloc/home_pages_bloc.dart';
import 'package:weather_station_client/presentation/router/app_router.gr.dart';
import 'package:weather_station_client/presentation/theme/theme_provider.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomePagesBloc>(),
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerDelegate: _appRouter.delegate(
          navigatorObservers: () => [ChuckerFlutter.navigatorObserver],
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: ThemeProvider(isDark: false).getThemeData(),
      ),
    );
  }
}
