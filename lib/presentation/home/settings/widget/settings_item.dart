import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';

class SettingsItem extends StatelessWidget {
  final PlainLocalizedString name;
  final VoidCallback onPressed;

  const SettingsItem({
    Key key,
    @required this.name,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        child: InkWell(
          onTap: onPressed,
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
      ),
    );
  }
}
