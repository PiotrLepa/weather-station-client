import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/presentation/configure_station/widgets/wifi_item.dart';

class WifiList extends StatelessWidget {
  final KtList<Wifi> wifiList;

  const WifiList({
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
            return WifiItem(
              item: wifiList[index],
            );
          },
        ),
      ],
    );
  }
}
