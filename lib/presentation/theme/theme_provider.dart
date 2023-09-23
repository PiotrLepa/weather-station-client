import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_station_client/gen/fonts.gen.dart';

class ThemeProvider {
  final bool isDark;

  Color get primaryColor => Colors.blue;

  Color get primaryColorLight => Colors.lightBlue.shade400;

  Color get primaryColorDark => Colors.blue.shade700;

  Color get accentColor => const Color(0xFF71887A);

  Color get textColorInverted => Colors.white;

  Color get textColorLightInverted => const Color(0xFFE8E8E8);

  Color get textColorLight => Colors.grey;

  Color get textColor => Colors.black87;

  Color get backgroundColorLight => Colors.white;

  Color get backgroundColor => Colors.grey.shade50;

  Color get backgroundColorDark => Colors.grey.shade200;

  Color get errorColor => Colors.red;

  ThemeProvider({required this.isDark});

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
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: accentColor,
        background: backgroundColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: FontFamily.lato,
      brightness: isDark ? Brightness.dark : Brightness.light,
      textTheme: const TextTheme(
        labelLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: Colors.blue,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColorInverted,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0x1F000000),
        thickness: 1,
      ),
    );
  }
}
