import 'package:kt_dart/collection.dart';

String enumToString(Object o) => o.toString().split('.').last;

T enumFromString<T extends Object>(String key, KtList<T> values) =>
    values.first((v) => key == enumToString(v));
