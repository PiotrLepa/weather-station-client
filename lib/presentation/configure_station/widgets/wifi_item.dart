import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/gen/assets.gen.dart';

class WifiItem extends StatelessWidget {
  final Wifi item;

  const WifiItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const SizedBox(width: 12),
          _getSignalIcon(context),
          const SizedBox(width: 24),
          Expanded(child: _getWifiName()),
          const SizedBox(width: 24),
          _getEncryptionIcon(context),
        ],
      ),
    );
  }

  SvgPicture _getSignalIcon(BuildContext context) {
    return item.signalStrength
        .map(
          excellent: (_) => Assets.icons.wifiSignalStrength4,
          strong: (_) => Assets.icons.wifiSignalStrength3,
          fair: (_) => Assets.icons.wifiSignalStrength2,
          weak: (_) => Assets.icons.wifiSignalStrength1,
        )
        .svg(
          width: 36,
          height: 36,
          color: ThemeProvider.of(context).accentColor,
        );
  }

  Widget _getWifiName() {
    return Text(
      item.name,
      maxLines: 1,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: scaleText(16),
      ),
    );
  }

  Widget _getEncryptionIcon(BuildContext context) {
    return item.encryption
            .map(
              open: (_) => null,
              wep: (_) => null,
              wpa: (_) => null,
              wpa2: (_) => Assets.icons.lock,
            )
            ?.svg(
              width: 24,
              height: 24,
            ) ??
        Container();
  }
}
