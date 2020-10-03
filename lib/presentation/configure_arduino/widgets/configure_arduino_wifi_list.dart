import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/presentation/configure_arduino/widgets/configure_arduino_wifi_item.dart';

class ConfigureArduinoWifiList extends StatelessWidget {
  final KtList<Wifi> wifiList;

  const ConfigureArduinoWifiList({
    Key key,
    @required this.wifiList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Wybierz sieć, z która ma sie połączyć Arduino',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: scaleText(24),
          ),
        ),
        ListView.builder(
          itemCount: wifiList.size,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ConfigureArduinoWifiItem(
              item: wifiList[index],
            );
          },
        ),
      ],
    );
  }
}
