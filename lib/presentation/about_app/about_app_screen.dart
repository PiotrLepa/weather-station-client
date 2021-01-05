import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/domain/bloc/about_app/about_app_bloc.dart';
import 'package:weather_station/presentation/about_app/widget/about_app_list.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<AboutAppBloc>(),
      child: Scaffold(
        body: BlocConsumer<AboutAppBloc, AboutAppState>(
          listener: _listenState,
          buildWhen: (oldState, newState) => newState is RenderItems,
          builder: _buildState,
        ),
      ),
    );
  }

  void _listenState(BuildContext context, AboutAppState state) {
    state.maybeMap(
      pushLicenseListScreen: (s) {
        appNavigator.pushLicenseListScreen(
          title: s.title,
          licenses: s.licenses,
        );
      },
      orElse: () {},
    );
  }

  Widget _buildState(BuildContext context, AboutAppState state) {
    return state.maybeMap(
      renderItems: (s) {
        return Scaffold(
          backgroundColor: ThemeProvider.of(context).backgroundColorDark,
          appBar: AppBar(
            title: Text(Strings.aboutAppItem.get(context)),
          ),
          body: AboutAppList(),
        );
      },
      orElse: () => const SizedBox(),
    );
  }
}
