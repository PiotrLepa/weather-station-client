import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/common/router/router.gr.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/domain/bloc/home/home_bloc.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>(),
      child: MaterialApp(
        localizationsDelegates: AutoLocalizedData.localizationsDelegates,
        supportedLocales: AutoLocalizedData.supportedLocales,
        theme: ThemeProvider(isDark: false).getThemeData(),
        // darkTheme: ThemeProvider(isDark: true).getThemeData(),
        builder: ExtendedNavigator.builder(
            router: Router(),
            navigatorKey: navigatorKey,
            builder: (BuildContext context, Widget child) {
              initializeDimens(context);
              return child;
            }),
      ),
    );
  }
}
