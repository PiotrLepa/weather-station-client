import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';

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
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  name.get(context),
                  style: TextStyle(
                    fontSize: scaleText(16),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Switch(
              value: isChecked,
              onChanged: onSwitchChanged,
            ),
          ],
        ),
      ),
    );
  }
}
