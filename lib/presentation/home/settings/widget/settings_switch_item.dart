import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/gen/assets.gen.dart';
import 'package:weather_station/presentation/home/settings/widget/settings_item_wrapper.dart';

class SettingsSwitchItem extends StatelessWidget {
  final PlainLocalizedString name;
  final bool isChecked;
  final void Function(bool isChecked) onSwitchChanged;

  const SettingsSwitchItem({
    Key key,
    @required this.name,
    @required this.isChecked,
    @required this.onSwitchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsItemWrapper(
      backgroundColor: ThemeProvider.of(context).backgroundColor,
      onTap: () {
        onSwitchChanged(!isChecked);
      },
      child: Row(
        children: [
          const SizedBox(width: 16),
          Assets.icons.notification.svg(
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              name.get(context),
              style: TextStyle(
                fontSize: scaleText(16),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Switch(
            value: isChecked,
            onChanged: onSwitchChanged,
          ),
        ],
      ),
    );
  }
}
