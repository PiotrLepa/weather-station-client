import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/common/router/app_router.gr.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/domain/bloc/fcm_bloc/fcm_bloc.dart';
import 'package:weather_station/domain/bloc/home/home_bloc.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    initializeDimens(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => getIt<FcmBloc>()..add(const Created()),
        ),
        BlocProvider(
          create: (_) => getIt<HomeBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        localizationsDelegates: AutoLocalizedData.localizationsDelegates,
        supportedLocales: AutoLocalizedData.supportedLocales,
        theme: ThemeProvider(isDark: false).getThemeData(),
        // darkTheme: ThemeProvider(isDark: true).getThemeData(),
      ),
    );
  }
}
