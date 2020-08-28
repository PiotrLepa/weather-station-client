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
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    String contentType,
  }) =>
      _responseConverter.decodeResponse(createRequest(
        "GET",
        path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        contentType: contentType,
      ));

  Future<KtList<T>> getList<T>(
    String path, {
    Serializable data,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    String contentType,
  }) =>
      _responseConverter.decodeResponseList(createRequest(
        "GET",
        path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        contentType: contentType,
      ));

  Future<T> post<T>(
    String path, {
    Serializable data,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    String contentType,
  }) =>
      _responseConverter.decodeResponse(createRequest(
        "POST",
        path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        contentType: contentType,
      ));

  Future<T> put<T>(
    String path, {
    Serializable data,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    String contentType,
  }) =>
      _responseConverter.decodeResponse(createRequest(
        "PUT",
        path,
        data: data,
        queryParameters: queryParameters,
        headers: headers,
        contentType: contentType,
      ));

  Future<Response<T>> createRequest<T>(
    String method,
    String path, {
    Serializable data,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> headers,
    String contentType,
  }) async =>
      _dio.request(path,
          data: data?.toJson(),
          queryParameters: queryParameters,
          options: Options(
            method: method,
            headers: headers,
            contentType: contentType,
          ));
}
