import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/domain/entity/station_exception/station_exception.dart';

@lazySingleton
class BleErrorHandler {
  Future<T> handleError<T>(dynamic error, StackTrace stackTrace) async {
    return Future.error(mapError(error));
  }

  StationException mapError(dynamic error) {
    if (error is StationException) {
      return error;
    }
    if (error is! BleError) {
      return const StationException.unknown();
    }
    switch (error.errorCode.value) {
      case BleErrorCode.operationCancelled:
        return const StationException.cancelled();
      default:
        return const StationException.unknown();
    }
  }
}

extension BleErrorHandlerFutureExtension<T> on Future<T> {
  Future<T> handleBleError() {
    final errorHandler = getIt<BleErrorHandler>();
    return catchError(
        (dynamic e, StackTrace s) => errorHandler.handleError<T>(e, s));
  }
}

extension BleErrorHandlerStreamExtension<T> on Stream<T> {
  Stream<T> mapAndRethrowBleError() {
    final errorHandler = getIt<BleErrorHandler>();
    return handleError(
        (Object e, StackTrace s) => throw errorHandler.mapError(e));
  }
}
