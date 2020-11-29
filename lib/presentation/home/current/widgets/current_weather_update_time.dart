import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/core/presentation/widgets/common/progress_button.dart';
import 'package:weather_station/domain/bloc/current_weather/current_weather_bloc.dart';
import 'package:weather_station/presentation/home/current/util/update_time_formatter.dart';

class CurrentWeatherUpdateTime extends StatefulWidget {
  final DateTime lastUpdateTime;
  final bool refreshLoading;

  const CurrentWeatherUpdateTime({
    Key key,
    @required this.lastUpdateTime,
    @required this.refreshLoading,
  }) : super(key: key);

  @override
  _CurrentWeatherUpdateTimeState createState() =>
      _CurrentWeatherUpdateTimeState();
}

class _CurrentWeatherUpdateTimeState extends State<CurrentWeatherUpdateTime> {
  final _updateTimeFormatter = getIt<UpdateTimeFormatter>();

  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
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
                  text: Strings.weatherUpdateTime.get(context),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: scaleText(17),
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
                    fontSize: scaleText(14),
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
                onPressed: () {
                  context
                      .read<CurrentWeatherBloc>()
                      .add(const RefreshPressed());
                },
                loading: widget.refreshLoading,
                backgroundColor: ThemeProvider
                    .of(context)
                    .primaryColorLight,
                progressColor: Colors.white,
                text: Strings.refresh,
                textStyle: TextStyle(
                  fontSize: scaleText(20),
                  color: ThemeProvider
                      .of(context)
                      .textColorInverted,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
