import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LicenseDetailsPage extends StatelessWidget {
  final String content;

  const LicenseDetailsPage({
    Key key,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(content),
      ),
    );
  }
}
