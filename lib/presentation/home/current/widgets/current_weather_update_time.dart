import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';
import 'package:weather_station/core/presentation/util/plural_util.dart';
import 'package:weather_station/core/presentation/widgets/common/progress_button.dart';
import 'package:weather_station/domain/bloc/current_weather/current_weather_bloc.dart';

class CurrentWeatherUpdateTime extends StatelessWidget {
  final pluralUtil = getIt<PluralUtil>();

  final DateTime lastUpdateTime;
  final bool refreshLoading;

  CurrentWeatherUpdateTime({
    Key key,
    @required this.lastUpdateTime,
    @required this.refreshLoading,
  }) : super(key: key);

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
            text:
                TextSpan(style: DefaultTextStyle.of(context).style, children: [
              TextSpan(
                text: context.translateKey('weatherUpdateTime'),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: scaleText(17),
                  color: ThemeProvider
                      .of(context)
                      .textColor,
                ),
              ),
              TextSpan(
                text: _formatLastUpdateTime(context, lastUpdateTime),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: scaleText(14),
                  color: ThemeProvider
                      .of(context)
                      .textColorLight,
                ),
              ),
            ]),
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
                      .bloc<CurrentWeatherBloc>()
                      .add(const CurrentWeatherEvent.refreshPressed());
                },
                loading: refreshLoading,
                backgroundColor: ThemeProvider
                    .of(context)
                    .primaryColorLight,
                progressColor: Colors.white,
                text: KeyString('refresh'),
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

  String _formatLastUpdateTime(BuildContext context, DateTime lastUpdateTime) {
    final difference = DateTime.now().difference(lastUpdateTime);
    final agoString = context.translateKey('updateTimeAgo');

    if (difference.inDays >= 1) {
      return '${context.translateKey('updateTimeMoreThanDay')} $agoString';
    } else if (difference.inHours >= 1) {
      final hoursForm = _getHoursForm(context, difference.inHours);
      return '${difference.inHours} $hoursForm $agoString';
    } else if (difference.inMinutes == 0) {
      return context.translateKey('updateTimeNow');
    } else {
      final minutesForm = _getMinutesForm(context, difference.inMinutes);
      return '${difference.inMinutes} $minutesForm $agoString';
    }
  }

  String _getMinutesForm(BuildContext context, int minutes) {
    return pluralUtil.applyPlurals(
      quantity: minutes,
      one: context.translateKey('pluralMinutesOne'),
      few: context.translateKey('pluralMinutesFew'),
      many: context.translateKey('pluralMinutesMany'),
    );
  }

  String _getHoursForm(BuildContext context, int hours) {
    return pluralUtil.applyPlurals(
      quantity: hours,
      one: context.translateKey('pluralHoursOne'),
      few: context.translateKey('pluralHoursFew'),
      many: context.translateKey('pluralHoursMany'),
    );
  }
}
