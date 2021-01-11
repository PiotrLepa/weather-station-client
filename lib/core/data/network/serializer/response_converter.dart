import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/common/serialization/model_decoder.dart';

@lazySingleton
class ResponseConverter {
  final ModelDecoder _modelDecoder;

  ResponseConverter(this._modelDecoder);

  Future<T> decodeResponse<T>(
    Future<Response> futureResponse,
  ) async {
    final response = await futureResponse;
    return _modelDecoder.decode<T>(response.data) as T;
  }

  Future<KtList<T>> decodeResponseList<T>(
    Future<Response> futureResponse,
  ) async {
    final response = await futureResponse;
    return _modelDecoder.decode<T>(response.data) as KtList<T>;
  }
}
