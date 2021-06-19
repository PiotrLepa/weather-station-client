import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/logger/logger.dart';

@lazySingleton
class LoggerInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.d('Request\n\n'
        '${options.method} ${options.uri}\n\n'
        'Headers: ${prettyJson(options.headers)}\n\n'
        "${options.data != null ? 'Json: ${prettyJson(options.data)}' : ''}");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('Response\n\n'
        '${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.uri}\n\n'
        'Json: ${prettyJson(response.data)}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      logger.d('Network error\n\n'
          '${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.uri}\n\n'
          'Error: ${err.toString()}\n\n'
          'Json: ${prettyJson(response.data)}');
    } else {
      logger.d('Network error\n\n'
          'Response: null\n\n'
          'Error: ${err.toString()}\n\n');
    }
    super.onError(err, handler);
  }
}
