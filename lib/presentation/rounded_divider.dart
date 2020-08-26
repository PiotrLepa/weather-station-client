import 'package:flutter/material.dart';

class RoundedDivider extends StatelessWidget {
  final double size;
  final double thickness;
  final double indent;
  final double endIndent;
  final double radius;
  final Color color;
  final bool vertical;

  RoundedDivider({
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
    final DividerThemeData dividerTheme = DividerTheme.of(context);
    final double height = this.size ?? dividerTheme.space ?? 16.0;
    final double thickness = this.thickness ?? dividerTheme.thickness ?? 0.0;
    final double indent = this.indent ?? dividerTheme.indent ?? 0.0;
    final double endIndent = this.endIndent ?? dividerTheme.endIndent ?? 0.0;
    final double radius = this.radius ?? 12;
    final bool vertical = this.vertical ?? false;
    final Color color = this.color ??
        (context != null
            ? (DividerTheme.of(context).color ?? Theme.of(context).dividerColor)
            : null);

    return SizedBox(
      height: vertical ? double.infinity : height,
      width: vertical ? height : double.infinity,
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
