import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_station/core/common/locale_provider.dart';
import 'package:weather_station/core/common/router/router.gr.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/localization/app_localizations.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/domain/bloc/home/home_bloc.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  final LocaleProvider _localeProvider = getIt.get<LocaleProvider>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeBloc>(),
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: _localeProvider.getSupportedLocales().asList(),
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
