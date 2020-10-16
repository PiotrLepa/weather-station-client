import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';

class LicenseItem extends StatelessWidget {
  final String name;

  const LicenseItem({
    Key key,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: scaleText(15),
        ),
      ),
    );
  }
}
