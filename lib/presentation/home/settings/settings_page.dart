import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/widgets/loading/loading_indicator.dart';
import 'package:weather_station/domain/bloc/settings/settings_bloc.dart';
import 'package:weather_station/presentation/home/settings/widget/settings_list.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<SettingsBloc>()..add(const PageStarted()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.settingsAppBarTitle.get(context)),
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return state.map(
              loading: (s) => const Center(child: LoadingIndicator()),
              renderItems: (s) => SettingsList(pushEnabled: s.pushEnabled),
            );
          },
        ),
      ),
    );
  }
}
