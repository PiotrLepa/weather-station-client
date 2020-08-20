import 'dart:convert';

import 'package:logger/logger.dart';

final logger = Logger();

String prettyJson(json) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  return encoder.convert(json);
}
