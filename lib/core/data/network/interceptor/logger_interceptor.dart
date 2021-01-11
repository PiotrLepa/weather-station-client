import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/logger/logger.dart';

@lazySingleton
class LoggerInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    logger.d('Request\n\n'
        '${options.method} ${options.uri}\n\n'
        'Headers: ${prettyJson(options.headers)}\n\n'
        "${options?.data != null ? 'Json: ${prettyJson(options.data)}' : ''}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    logger.d('Response\n\n'
        '${response.statusCode} ${response.request.method} ${response.request.uri}\n\n'
        'Json: ${prettyJson(response?.data)}');
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    final response = err.response;
    if (response != null) {
      logger.d('Network error\n\n'
          '${response.statusCode} ${response.request.method} ${response.request.uri}\n\n'
          'Error: ${err.toString()}\n\n'
          'Json: ${prettyJson(response?.data)}');
    } else {
      logger.d('Network error\n\n'
          'Response: null\n\n'
          'Error: ${err.toString()}\n\n');
    }
    return super.onError(err);
  }
}
