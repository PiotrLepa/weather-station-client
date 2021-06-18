import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/data/network/exception/api/api_exception.dart';

@lazySingleton
class ConnectionInterceptor extends InterceptorsWrapper {
  final DataConnectionChecker _dataConnectionChecker;

  ConnectionInterceptor(this._dataConnectionChecker);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final hasConnection = await _dataConnectionChecker.hasConnection;

    if (!hasConnection) {
      throw const NoConnection();
    }

    super.onRequest(options, handler);
  }
}
