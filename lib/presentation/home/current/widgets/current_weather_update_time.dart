import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
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
                text: 'Zaktualizowano: ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimens.scale(17),
                  color: ThemeProvider.of(context).textColor,
                ),
              ),
              TextSpan(
                text: _formatLastUpdateTime(lastUpdateTime),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Dimens.scale(14),
                  color: ThemeProvider.of(context).textColorLight,
                ),
              ),
            ]),
          ),
          Divider(
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
                      .add(CurrentWeatherEvent.refreshPressed());
                },
                loading: refreshLoading,
                backgroundColor: ThemeProvider.of(context).primaryColorLight,
                progressColor: Colors.white,
                text: 'Odśwież',
                textStyle: TextStyle(
                  fontSize: Dimens.scale(20),
                  color: ThemeProvider.of(context).textColorInverted,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String _formatLastUpdateTime(DateTime lastUpdateTime) {
    final difference = DateTime.now().difference(lastUpdateTime);

    if (difference.inDays >= 1) {
      return 'Ponad dzień temu';
    } else if (difference.inHours >= 1) {
      String hoursForm = _getHoursForm(difference.inHours);
      return '${difference.inHours} $hoursForm temu';
    } else if (difference.inMinutes == 0) {
      return 'Teraz';
    } else {
      String minutesForm = _getMinutesForm(difference.inMinutes);
      return '${difference.inMinutes} $minutesForm temu';
    }
  }

  String _getMinutesForm(int minutes) {
    return pluralUtil.applyPlurals(
      quantity: minutes,
      one: 'minutę',
      few: 'minuty',
      many: 'minut',
    );
  }

  String _getHoursForm(int hours) {
    return pluralUtil.applyPlurals(
      quantity: hours,
      one: 'godzinę',
      few: 'godziny',
      many: 'godzin',
    );
  }
}
