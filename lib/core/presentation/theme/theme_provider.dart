import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/dimens.dart';

class ThemeProvider {
  final bool isDark;

  Color get primaryColor => Colors.blue;

  Color get primaryColorLight => Colors.lightBlue[400];

  Color get primaryColorDark => Colors.blue[700];

  Color get accentColor => Color(0xFF5CA594);

  Color get textColorInverted => Colors.white;

  Color get textColorLightInverted => Color(0xFFE8E8E8);

  Color get textColorLight => Colors.grey;

  Color get textColor => Colors.black87;

  Color get backgroundColor => Colors.grey[50];

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
        textTheme: ButtonTextTheme.primary,
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
