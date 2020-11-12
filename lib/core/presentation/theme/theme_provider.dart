import 'package:flutter/material.dart';
import 'package:weather_station/core/presentation/widgets/common/dimens.dart';
import 'package:weather_station/gen/fonts.gen.dart';

class ThemeProvider {
  final bool isDark;

  Color get primaryColor => Colors.blue;

  Color get primaryColorLight => Colors.lightBlue[400];

  Color get primaryColorDark => Colors.blue[700];

  Color get accentColor => const Color(0xFF71887A);

  Color get textColorInverted => Colors.white;

  Color get textColorLightInverted => const Color(0xFFE8E8E8);

  Color get textColorLight => Colors.grey;

  Color get textColor => Colors.black87;

  Color get backgroundColorLight => Colors.white;

  Color get backgroundColor => Colors.grey[50];

  Color get backgroundColorDark => Colors.grey[200];

  ThemeProvider({@required this.isDark});

  factory ThemeProvider.of(BuildContext context) {
    return ThemeProvider(
      isDark: MediaQuery.of(context).platformBrightness == Brightness.dark,
    );
  }

  ThemeData getThemeData() {
    return ThemeData(
      primaryColor: primaryColor,
      primaryColorLight: primaryColorLight,
      primaryColorDark: primaryColorDark,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: FontFamily.lato,
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: TextTheme(
        button: TextStyle(
          fontSize: scaleText(20),
          fontWeight: FontWeight.bold,
        ),
      ),
      buttonTheme: ButtonThemeData(
        padding: const EdgeInsets.all(12),
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
            fontSize: scaleText(22),
            fontWeight: FontWeight.bold,
            color: textColorInverted,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0x1F000000),
        thickness: 1,
      ),
    );
  }
}
