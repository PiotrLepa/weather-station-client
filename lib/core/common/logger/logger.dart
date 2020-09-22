import 'dart:convert';

import 'package:logger/logger.dart';

final logger = Logger();

String prettyJson(dynamic json) =>
    const JsonEncoder.withIndent('  ').convert(json);
