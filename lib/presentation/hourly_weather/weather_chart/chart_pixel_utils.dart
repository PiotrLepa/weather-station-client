import 'package:flutter/painting.dart';

class ChartPixelCalculator<X extends num, Y extends num> {
  Size _size;
  X _minX;
  X _maxX;
  Y _minY;
  Y _maxY;
  Y _topOffSet;
  Y _bottomOffSet;

  void initialize(
    Size size, {
    X minX,
    X maxX,
    Y minY,
    Y maxY,
    Y topOffSet,
    Y bottomOffSet,
  }) {
    _size = size;
    _minX = minX;
    _maxX = maxX;
    _minY = minY;
    _maxY = maxY;
    _topOffSet = topOffSet ?? 0;
    _bottomOffSet = bottomOffSet ?? 0;
  }

  double getPixelX(X spotX) {
    if (_minX == null || _maxX == null) {
      throw XSpotsNotInitialized;
    }

    final double difference = _maxX - _minX.toDouble();
    if (difference == 0.0) {
      return 0;
    }

    return (spotX - _minX) / difference * _size.width;
  }

  double getPixelY(Y spotY) {
    if (_minY == null || _maxY == null) {
      throw YSpotsNotInitialized;
    }

    final double difference = _maxY - _minY.toDouble();
    if (difference == 0.0) {
      return _size.height + _bottomOffSet;
    }

    double y = (spotY - _minY) / difference *
        (_size.height - _topOffSet - _bottomOffSet);
    return _size.height - y - _bottomOffSet;
  }
}

class XSpotsNotInitialized implements Exception {}

class YSpotsNotInitialized implements Exception {}
