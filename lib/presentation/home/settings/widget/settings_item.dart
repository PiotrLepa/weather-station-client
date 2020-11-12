import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/presentation/home/settings/widget/settings_item_wrapper.dart';

class SettingsItem extends StatelessWidget {
  final PlainLocalizedString name;
  final Widget leftIcon;
  final VoidCallback onPressed;

  const SettingsItem({
    Key key,
    @required this.name,
    this.leftIcon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsItemWrapper(
      backgroundColor: ThemeProvider.of(context).backgroundColorLight,
      onTap: onPressed,
      child: Row(
        children: [
          _getLeftIcon(),
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
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _getLeftIcon() {
    if (leftIcon == null) {
      return const SizedBox(width: 16);
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 20,
        ),
        child: leftIcon,
      );
    }
  }
}
