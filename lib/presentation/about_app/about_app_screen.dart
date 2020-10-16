import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/settings/settings_bloc.dart';
import 'package:weather_station/presentation/home/settings/widget/settings_item.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<SettingsBloc>(),
      child: Scaffold(
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(Strings.aboutAppItem.get(context)),
              ),
              body: _buildPage(context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SettingsItem(
            name: Strings.aboutAppIconsItem,
            onPressed: () {},
          ),
          SettingsItem(
            name: Strings.aboutAppPackagesItem,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
