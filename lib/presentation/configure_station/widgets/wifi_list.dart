import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/common/disable_overscroll_glow_behavior.dart';
import 'package:weather_station/domain/bloc/configure_station/configure_station_bloc.dart';
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
      padding: const EdgeInsets.only(top: 12),
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
      child: ScrollConfiguration(
        behavior: DisableOverscrollGlowBehavior(),
        child: ListView.builder(
          itemCount: wifiList.size,
          itemBuilder: (context, index) {
            return Material(
              child: InkWell(
                onTap: () {
                  context
                      .read<ConfigureStationBloc>()
                      .add(OnWifiSelected(wifiList[index]));
                },
                child: Column(
                  children: [
                    WifiItem(item: wifiList[index]),
                    const Padding(
                      padding: EdgeInsets.only(left: 84),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
