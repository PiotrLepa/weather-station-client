import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/settings/settings_bloc.dart';
import 'package:weather_station/presentation/home/settings/widget/settings_item.dart';
import 'package:weather_station/presentation/home/settings/widget/settings_switch_item.dart';

class SettingsList extends StatelessWidget {
  final bool pushEnabled;

  const SettingsList({
    Key key,
    this.pushEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SettingsItem(
            name: Strings.settingsItemConfigureWifiOnStation,
            onPressed: () {
              context.read<SettingsBloc>().add(const ConfigureWifiClicked());
            },
          ),
          SettingsItem(
            name: Strings.aboutAppItem,
            onPressed: () {
              context.read<SettingsBloc>().add(const AboutAppClicked());
            },
          ),
          SettingsSwitchItem(
            name: Strings.poshNotificationsItem,
            isChecked: pushEnabled,
            onSwitchChanged: (isChecked) {
              context
                  .read<SettingsBloc>()
                  .add(PushNotificationsSwitchChanged(isChecked: isChecked));
            },
          ),
        ],
      ),
    );
  }
}
