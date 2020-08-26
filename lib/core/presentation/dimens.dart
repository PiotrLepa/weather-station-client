import 'package:flutter/cupertino.dart';

class Dimens {
  static double screenWidth;
  static double screenHeight;
  static Size screenSize;

  static void initialize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    if (screenWidth > 360) {
      screenSize = Size.large;
    } else if (screenWidth > 320) {
      screenSize = Size.medium;
    } else {
      screenSize = Size.small;
    }
  }

  static double scale(double size) {
    if (screenSize == Size.small) {
      return size * 0.8;
    } else if (screenSize == Size.medium) {
      return size * 0.9;
    } else {
      return size;
    }
  }
}

enum Size {
  small,
  medium,
  large,
}
