import 'package:flutter/material.dart';

class RoundedDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final double radius;
  final Color color;

  RoundedDivider({
    this.height,
    this.thickness,
    this.indent,
    this.endIndent,
    this.radius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final DividerThemeData dividerTheme = DividerTheme.of(context);
    final double height = this.height ?? dividerTheme.space ?? 16.0;
    final double thickness = this.thickness ?? dividerTheme.thickness ?? 0.0;
    final double indent = this.indent ?? dividerTheme.indent ?? 0.0;
    final double endIndent = this.endIndent ?? dividerTheme.endIndent ?? 0.0;
    final double radius = this.radius ?? 12;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Center(
        child: Container(
          height: thickness,
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
