import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';

class ThemeProvider {
  final bool isDark;

  Color get primaryColor => Colors.blue;

  Color get primaryColorLight => Colors.lightBlue[400];

  Color get primaryColorDark => Colors.blueGrey;

  Color get accentColor => Color(0xFFF6CD61);

  Color get textColorInverted => Colors.white;

  Color get textColorLightInverted => Colors.white60;

  Color get textColorLight => Colors.grey;

  Color get textColor => Colors.black87;

  Color get backgroundColor => isDark ? Colors.grey[850] : Colors.grey[50];

  factory ThemeProvider.of(BuildContext context) {
    return ThemeProvider(
      isDark: MediaQuery.of(context).platformBrightness == Brightness.dark,
    );
  }

  ThemeProvider({@required this.isDark});

  ThemeData getThemeData() {
    return ThemeData(
      primaryColor: primaryColor,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'Lato',
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: TextTheme(
        button: TextStyle(
          fontSize: Dimens.scale(20),
          fontWeight: FontWeight.bold,
        ),
      ),
      buttonTheme: ButtonThemeData(
        padding: EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        buttonColor: primaryColor,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.blue,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: Dimens.scale(22),
            fontWeight: FontWeight.bold,
            color: textColorInverted,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: const Color(0x1F000000),
        thickness: 1,
      ),
    );
  }
}
