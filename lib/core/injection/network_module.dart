import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/network/interceptor/connection_interceptor.dart';
import 'package:weather_station/core/data/network/interceptor/language_interceptor.dart';
import 'package:weather_station/core/data/network/interceptor/logger_interceptor.dart';
import 'package:weather_station/core/data/network/network_constant.dart';
import 'package:weather_station/core/injection/injection.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dioDefault => Dio()
    ..options.baseUrl = baseUrl
    ..interceptors.add(getIt.get<LanguageInterceptor>())
    ..interceptors.add(getIt.get<LoggerInterceptor>())
    ..interceptors.add(getIt.get<ConnectionInterceptor>());
}
