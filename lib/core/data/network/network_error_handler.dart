import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/logger/logger.dart';
import 'package:weather_station/core/data/model/error/error_response.dart';
import 'package:weather_station/core/data/network/exception/api/api_exception.dart';
import 'package:weather_station/core/injection/injection.dart';

@lazySingleton
class NetworkErrorHandler {
  Future<T> handleError<T>(dynamic error, StackTrace stackTrace) async {
    if (error is DioError) {
      final apiException = _mapError(error);
      return Future.error(apiException);
    } else {
      return Future.error(const ApiException.unknownError(-1, null));
    }
  }

  ApiException _mapError(DioError dioError) {
    if (dioError.error is ApiException) {
      return dioError.error as ApiException;
    }
    final response = dioError.response;
    final statusCode = response?.statusCode;
    try {
      final data = response.data as Map<String, dynamic>; // TODO check cast
      convertModelCodePropertyToInt(data);
      final errorResponse = ErrorResponse.fromJson(data);
      final exception = _mapToApiException(statusCode, errorResponse);
      return exception;
      // ignore: avoid_catching_errors
    } on TypeError catch (e) {
      logger.e(e);
      return ApiException.unknownError(statusCode, null);
    } catch (e) {
      logger.e(e);
      return ApiException.unknownError(statusCode, null);
    }
  }

  dynamic convertModelCodePropertyToInt(Map<String, dynamic> data) {
    final dynamic code = data['code'];
    if (code is String) {
      data['code'] = int.parse(data['code'] as String); // TODO better way?
    }
  }

  ApiException _mapToApiException(int statusCode, ErrorResponse errorResponse) {
    switch (statusCode) {
      case 400:
        return ApiException.badRequest(
            statusCode, errorResponse.printableMessage);
      case 500:
        return ApiException.internalServerError(
            statusCode, errorResponse.printableMessage);
      default:
        return ApiException.unknownError(
            statusCode, errorResponse.printableMessage);
    }
  }
}

extension FutureExtension<T> on Future<T> {
  Future<T> handleNetworkError() {
    final errorHandler = getIt<NetworkErrorHandler>();
    return catchError(
        (dynamic e, StackTrace s) => errorHandler.handleError<T>(e, s));
  }
}
