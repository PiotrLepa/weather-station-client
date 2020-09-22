import 'package:dio/dio.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/common/serialization/serializable.dart';
import 'package:weather_station/core/data/network/serializer/response_converter.dart';

abstract class BaseRestService {
  final Dio _dio;
  final ResponseConverter _responseConverter;

  BaseRestService(
    this._dio,
    this._responseConverter,
  );

  Future<T> get<T>(
    String path, {
    Serializable data,
    Map<String, String> params,
    Map<String, String> headers,
    String contentType,
  }) =>
      _responseConverter.decodeResponse(createRequest<dynamic>(
        'GET',
        path,
        data: data,
        params: params,
        headers: headers,
        contentType: contentType,
      ));

  Future<KtList<T>> getList<T>(
    String path, {
        Serializable data,
        Map<String, String> params,
        Map<String, String> headers,
        String contentType,
      }) =>
      _responseConverter.decodeResponseList(createRequest<dynamic>(
        'GET',
        path,
        data: data,
        params: params,
        headers: headers,
        contentType: contentType,
      ));

  Future<T> post<T>(String path, {
    Serializable data,
    Map<String, String> params,
    Map<String, String> headers,
    String contentType,
  }) =>
      _responseConverter.decodeResponse(createRequest<dynamic>(
        'POST',
        path,
        data: data,
        params: params,
        headers: headers,
        contentType: contentType,
      ));

  Future<T> put<T>(String path, {
    Serializable data,
    Map<String, String> params,
    Map<String, String> headers,
    String contentType,
  }) =>
      _responseConverter.decodeResponse(createRequest<dynamic>(
        'PUT',
        path,
        data: data,
        params: params,
        headers: headers,
        contentType: contentType,
      ));

  Future<Response<T>> createRequest<T>(String method,
      String path, {
        Serializable data,
        Map<String, String> params,
        Map<String, String> headers,
        String contentType,
      }) async =>
      _dio.request(path,
          data: data?.toJson(),
          queryParameters: params,
          options: Options(
            method: method,
            headers: headers,
            contentType: contentType,
          ));
}
