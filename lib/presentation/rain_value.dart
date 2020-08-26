import 'package:flutter/material.dart';

class RainValue extends StatelessWidget {
  final String value;
  final String unit;

  const RainValue({
    Key key,
    @required this.value,
    @required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: '$value ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          TextSpan(
            text: unit,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
