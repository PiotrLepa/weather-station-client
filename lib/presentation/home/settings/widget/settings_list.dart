import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/settings/settings_bloc.dart';
import 'package:weather_station/presentation/home/settings/widget/settings_item.dart';

class SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SettingsItem(
            name: Strings.settingsItemConfigureWifiOnStation,
            onPressed: () {
              context.read<SettingsBloc>().add(const OnConfigureWifiClicked());
            },
          ),
          SettingsItem(
            name: Strings.aboutAppItem,
            onPressed: () {
              context.read<SettingsBloc>().add(const OnAboutAppClicked());
            },
          ),
        ],
      ),
    );
  }
}
