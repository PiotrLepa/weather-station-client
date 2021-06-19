import 'package:flutter/material.dart';

class RoundedDivider extends StatelessWidget {
  final double? size;
  final double? thickness;
  final double? indent;
  final double? endIndent;
  final double? radius;
  final Color? color;
  final bool? vertical;

  const RoundedDivider({
    this.size,
    this.thickness,
    this.indent,
    this.endIndent,
    this.radius,
    this.color,
    this.vertical,
  });

  @override
  Widget build(BuildContext context) {
    final dividerTheme = DividerTheme.of(context);
    final size = this.size ?? dividerTheme.space ?? 16.0;
    final thickness = this.thickness ?? dividerTheme.thickness ?? 0.0;
    final indent = this.indent ?? dividerTheme.indent ?? 0.0;
    final endIndent = this.endIndent ?? dividerTheme.endIndent ?? 0.0;
    final radius = this.radius ?? 12;
    final vertical = this.vertical ?? false;
    final color = this.color ??
        DividerTheme.of(context).color ??
        Theme.of(context).dividerColor;

    return SizedBox(
      height: vertical ? double.infinity : size,
      width: vertical ? size : double.infinity,
      child: Center(
        child: Container(
          height: vertical ? double.infinity : thickness,
          width: vertical ? thickness : double.infinity,
          margin: EdgeInsetsDirectional.only(
            start: indent,
            end: endIndent,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
        ),
      ),
    );
  }
}
