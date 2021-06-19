import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/loading/loading_indicator.dart';
import 'package:weather_station/domain/bloc/settings/settings_bloc.dart';
import 'package:weather_station/presentation/home/settings/widget/settings_list.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<SettingsBloc>()..add(const PageStarted()),
      child: Scaffold(
        backgroundColor: ThemeProvider.of(context).backgroundColorDark,
        appBar: AppBar(
          title: Text(Strings.settingsAppBarTitle.get(context)),
        ),
        body: BlocConsumer<SettingsBloc, SettingsState>(
          listener: _listenState,
          buildWhen: (oldState, newState) =>
              newState is Loading || newState is RenderItems,
          builder: _buildState,
        ),
      ),
    );
  }

  void _listenState(BuildContext context, SettingsState state) {
    state.maybeMap(
      pushConfigureStationScreen: (s) {
        context.router.push(const ConfigureStationScreenRoute());
      },
      pushAboutAppScreen: (s) {
        context.router.push(const AboutAppScreenRoute());
      },
      orElse: () {},
    );
  }

  Widget _buildState(BuildContext context, SettingsState state) {
    return state.maybeMap(
      loading: (s) => const Center(child: LoadingIndicator()),
      renderItems: (s) => SettingsList(pushEnabled: s.pushEnabled),
      orElse: () => const SizedBox(),
    );
  }
}
