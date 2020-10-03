import 'package:flutter/material.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';

class ConfigureArduinoWifiItem extends StatelessWidget {
  final Wifi item;

  const ConfigureArduinoWifiItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(item.toString());
  }
}
