import 'package:flutter/painting.dart';
import 'package:weather_station/presentation/home/hourly/widgets/weather_chart/chart_constants.dart';

class ChartPixelCalculator<Y extends num> {
  Size _size;
  Y _minY;
  double _diffY;
  int _topOffSet;
  int _bottomOffSet;

  void initialize(
    Size size, {
    Y minY,
    Y maxY,
    int topOffSet,
    int bottomOffSet,
  }) {
    _size = size;
    _minY = minY;
    _topOffSet = topOffSet ?? 0;
    _bottomOffSet = bottomOffSet ?? 0;
    if (minY != null && maxY != null) {
      _diffY = maxY.toDouble() - minY.toDouble();
    }
  }

  double getPixelX(int spotX) {
    if (spotX == 0) {
      return 0;
    }

    return spotX * spotWidth;
  }

  double getPixelY(
    Y spotY, {
    bool centerOnZero = false,
  }) {
    if (_diffY == null) {
      throw YSpotsNotInitialized;
    }

    if (_diffY == 0.0) {
      if (centerOnZero) {
        return _size.height / 2;
      } else {
        return _size.height + _bottomOffSet;
      }
    }

    final usableHeight = _size.height - _topOffSet - _bottomOffSet;
    final y = (spotY - _minY) / _diffY * usableHeight;
    return _size.height - _bottomOffSet - y;
  }
}

class YSpotsNotInitialized implements Exception {}
