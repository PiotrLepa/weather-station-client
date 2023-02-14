import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_station_client/di/dependency_injection.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/util/update_time_formatter.dart';
import 'package:weather_station_client/feature/home/pages/current/presentation/widgets/progress_button.dart';
import 'package:weather_station_client/presentation/extensions.dart';
import 'package:weather_station_client/presentation/theme/theme_provider.dart';

class CurrentWeatherUpdateTime extends StatefulWidget {
  final DateTime lastUpdateTime;
  final bool refreshLoading;

  const CurrentWeatherUpdateTime({
    Key? key,
    required this.lastUpdateTime,
    required this.refreshLoading,
  }) : super(key: key);

  @override
  CurrentWeatherUpdateTimeState createState() =>
      CurrentWeatherUpdateTimeState();
}

class CurrentWeatherUpdateTimeState extends State<CurrentWeatherUpdateTime> {
  final _updateTimeFormatter = getIt<UpdateTimeFormatter>();

  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      // Rebuild widget to update last update time
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    return super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: context.strings.currentWeatherLastUpdateTime,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: ThemeProvider.of(context).textColor,
                  ),
                ),
                TextSpan(
                  text: _updateTimeFormatter.format(
                    context,
                    widget.lastUpdateTime,
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ThemeProvider.of(context).textColorLight,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 24,
            indent: 24,
            endIndent: 24,
            thickness: 2,
          ),
          Wrap(
            children: [
              ProgressButton(
                loading: widget.refreshLoading,
                text: context.strings.currentWeatherRefreshButton,
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
                onPressed: () {
                  // TODO add on click
                  // context
                  //     .read<CurrentWeatherBloc>()
                  //     .add(const RefreshPressed());
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
