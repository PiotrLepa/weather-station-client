import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;

  const LoadingIndicator({
    Key key,
    this.size = 36,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CircularProgressIndicator(),
    );
  }
}
