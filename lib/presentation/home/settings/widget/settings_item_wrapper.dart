import 'package:flutter/material.dart';

class SettingsItemWrapper extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final VoidCallback onTap;

  const SettingsItemWrapper({
    Key key,
    @required this.backgroundColor,
    @required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8));
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: Material(
        color: backgroundColor,
        borderRadius: borderRadius,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: child,
        ),
      ),
    );
  }
}
