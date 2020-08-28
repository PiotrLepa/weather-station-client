import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/network/serializer/response_converter.dart';
import 'package:weather_station/core/data/network/service/base_rest_service.dart';
import 'package:weather_station/data/model/weather/weather_model.dart';

@lazySingleton
class RestService extends BaseRestService {
  RestService(
    Dio dio,
    ResponseConverter responseConverter,
  ) : super(dio, responseConverter);

  Future<WeatherModel> fetchCurrentWeather() => get("/weather/current");
}
