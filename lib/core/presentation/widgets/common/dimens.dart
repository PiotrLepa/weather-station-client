import 'package:flutter/material.dart';

double screenWidth;
double screenHeight;
Size screenSize;

void initializeDimens(BuildContext context) {
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

double scaleText(double size) {
  if (screenSize == Size.small) {
    return size * 0.8;
  } else if (screenSize == Size.medium) {
    return size * 0.9;
  } else {
    return size;
  }
}

enum Size {
  small,
  medium,
  large,
}
