import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';
import 'package:weather_station/core/presentation/theme/theme_provider.dart';

class HomeRefreshTime extends StatelessWidget {
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
                text: '15 minut temu',
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
              RaisedButton(
                onPressed: () {},
                color: ThemeProvider.of(context).primaryColorLight,
                child: Text(
                  "Odśwież",
                  style: TextStyle(
                    fontSize: 20,
                    color: ThemeProvider.of(context).textColorInverted,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
