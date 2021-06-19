import 'package:flutter/material.dart';

// FIXME if [scaleDimen] is used before invoking [initializeDimens] then dimens are scaled with default value (Size.large)
// eg [ThemeProvider] class invokes [scaleDimen] before invoking [initializeDimens]
Size screenSize = Size.large;

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
