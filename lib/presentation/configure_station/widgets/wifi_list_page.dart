import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/presentation/configure_station/widgets/wifi_list.dart';

class WifiListPage extends StatelessWidget {
  final KtList<Wifi> wifiList;

  const WifiListPage({
    Key key,
    @required this.wifiList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          child: Text(
            Strings.selectWifiToConnect.get(context),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: scaleText(22),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Expanded(child: WifiList(wifiList: wifiList)),
      ],
    );
  }
}
