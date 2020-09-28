import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/gen/assets.gen.dart';

class ConfigureArduinoConnecting extends StatelessWidget {
  final SvgGenImage image;

  const ConfigureArduinoConnecting({
    Key key,
    @required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width - 100;
    return SizedBox.expand(
      child: Column(
        children: [
          const SizedBox(height: 48),
          SizedBox(
            width: double.infinity,
            child: Text(
              Strings.arduinoWifiConnectingWithDevice.get(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: scaleText(20),
              ),
            ),
          ),
          const SizedBox(height: 64),
          image.svg(
            width: imageSize,
            height: imageSize,
          ),
        ],
      ),
    );
  }
}
