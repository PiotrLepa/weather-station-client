import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_station/core/common/raw_key_string.dart';
import 'package:weather_station/core/extension/build_context_extension.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/gen/assets.gen.dart';
import 'package:weather_station/presentation/home/current/widgets/cards/weather_card.dart';

class HumidityCard extends StatelessWidget {
  final double humidity;

  const HumidityCard({
    Key key,
    @required this.humidity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherCard(
      color: const Color(0xff67e4dc),
      iconPath: Assets.icons.humidity.path,
      title: KeyString('cardHumidity'),
      body: Text(
        '$humidity ${context.translateKey('humidityUnit')}',
        style: TextStyle(
          fontSize: scaleText(20),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
