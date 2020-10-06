import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: ThemeProvider.of(context).backgroundColorLight,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: wifiList.size,
        itemBuilder: (context, index) {
          return Column(
            children: [
              WifiItem(
                item: wifiList[index],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 84),
                child: Divider(height: 2),
              ),
            ],
          );
        },
      ),
    );
  }
}
