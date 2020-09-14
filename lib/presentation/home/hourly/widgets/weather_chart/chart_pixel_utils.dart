import 'package:flutter/painting.dart';

class ChartPixelCalculator<X extends num, Y extends num> {
  Size _size;
  X _minX;
  X _maxX;
  Y _minY;
  Y _maxY;
  double _diffX;
  double _diffY;
  int _topOffSet;
  int _bottomOffSet;

  void initialize(
    Size size, {
    X minX,
    X maxX,
    Y minY,
    Y maxY,
    int topOffSet,
    int bottomOffSet,
  }) {
    _size = size;
    _minX = minX;
    _maxX = maxX;
    _minY = minY;
    _maxY = maxY;
    _topOffSet = topOffSet ?? 0;
    _bottomOffSet = bottomOffSet ?? 0;
    if (minX != null && maxX != null) {
      _diffX = maxX - minX.toDouble();
    }
    if (minY != null && maxY != null) {
      _diffY = maxY - minY.toDouble();
    }
  }

  double getPixelX(X spotX) {
    if (_diffX == null) {
      throw XSpotsNotInitialized;
    }

    if (_diffX == 0.0) {
      return 0;
    }

    return (spotX - _minX) / _diffX * _size.width;
  }

  double getPixelY(Y spotY) {
    if (_diffY == null) {
      throw YSpotsNotInitialized;
    }

    if (_diffY == 0.0) {
      return _size.height + _bottomOffSet;
    }

    final usableHeight = _size.height - _topOffSet - _bottomOffSet;
    double y = (spotY - _minY) / _diffY * usableHeight;
    return _size.height - _bottomOffSet - y;
  }
}

class XSpotsNotInitialized implements Exception {}

class YSpotsNotInitialized implements Exception {}
