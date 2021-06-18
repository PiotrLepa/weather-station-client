import 'package:flutter/material.dart';

Size screenSize = Size.large; // TODO

void initializeDimens(BuildContext context) {
  final size = MediaQuery.of(context).size;
  if (size.width > 360) {
    screenSize = Size.large;
  } else if (size.width > 320) {
    screenSize = Size.medium;
  } else {
    screenSize = Size.small;
  }
}

double scaleDimen(double size) {
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
