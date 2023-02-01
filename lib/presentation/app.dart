import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station_client/di/dependency_injection.dart';
import 'package:weather_station_client/domain/bloc/home/home_pages_bloc.dart';
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
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        theme: ThemeProvider(isDark: false).getThemeData(),
      ),
    );
  }
}
