import 'package:flutter/material.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';

class WifiItem extends StatelessWidget {
  final Wifi item;

  const WifiItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(item.toString());
  }
}
