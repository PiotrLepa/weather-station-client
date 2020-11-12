import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/settings/settings_bloc.dart';
import 'package:weather_station/gen/assets.gen.dart';
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
          const SizedBox(height: 12),
          Assets.icons.appIcon.svg(
            width: 250,
            height: 250,
          ),
          const SizedBox(height: 16),
          ..._buildItems(context),
        ],
      ),
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    return [
      SettingsItem(
        name: Strings.settingsItemConfigureWifiOnStation,
        leftIcon: Assets.icons.configureWifi.svg(
          width: 24,
          height: 24,
        ),
        onPressed: () {
          context.read<SettingsBloc>().add(const ConfigureWifiClicked());
        },
      ),
      const SizedBox(height: 10),
      SettingsItem(
        name: Strings.aboutAppItem,
        leftIcon: Assets.icons.info.svg(
          width: 24,
          height: 24,
        ),
        onPressed: () {
          context.read<SettingsBloc>().add(const AboutAppClicked());
        },
      ),
      const SizedBox(height: 18),
      SettingsSwitchItem(
        name: Strings.poshNotificationsItem,
        isChecked: pushEnabled,
        onSwitchChanged: (isChecked) {
          context
              .read<SettingsBloc>()
              .add(PushNotificationsSwitchChanged(isChecked: isChecked));
        },
      ),
    ];
  }
}
