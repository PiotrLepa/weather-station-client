import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FillEmptySpaceSliver extends LeafRenderObjectWidget {
  final double minHeaderHeight;
  final double maxHeaderHeight;

  FillEmptySpaceSliver({
    @required this.minHeaderHeight,
    @required this.maxHeaderHeight,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _FillSpaceRenderer(minHeaderHeight, maxHeaderHeight);
  }
}

class _FillSpaceRenderer extends RenderSliver {
  final double _minHeaderHeight;
  final double _maxHeaderHeight;

  _FillSpaceRenderer(
    this._minHeaderHeight,
    this._maxHeaderHeight,
  );

  @override
  void performLayout() {
    double maxHeight = this.constraints.viewportMainAxisExtent -
        (this.constraints.precedingScrollExtent - _maxHeaderHeight) -
        _minHeaderHeight;

    if (maxHeight < 0.0) maxHeight = 0.0;

    this.geometry = SliverGeometry(scrollExtent: maxHeight);
  }
}
