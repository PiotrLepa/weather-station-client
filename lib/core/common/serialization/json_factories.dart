import 'package:weather_station/core/data/model/error/error_response.dart';
import 'package:weather_station/data/model/available_days/available_days_model.dart';
import 'package:weather_station/data/model/hourly_weather/hourly_weather_model.dart';
import 'package:weather_station/data/model/notification/notification_model.dart';
import 'package:weather_station/data/model/weather/weather_model.dart';

const Map<Type, Object Function(Map<String, dynamic> json)> jsonFactories = {
  ErrorResponse: ErrorResponse.fromJsonFactory,
  WeatherModel: WeatherModel.fromJsonFactory,
  HourlyWeatherModel: HourlyWeatherModel.fromJsonFactory,
  AvailableDaysModel: AvailableDaysModel.fromJsonFactory,
  NotificationModel: NotificationModel.fromJsonFactory,
};
