import 'package:weather_station/core/data/model/error/error_response.dart';

const Map<Type, Object Function(Map<String, dynamic> json)> jsonFactories = {
  ErrorResponse: ErrorResponse.fromJsonFactory,
};
