import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_exception.freezed.dart';

@freezed
abstract class ApiException with _$ApiException implements Exception {
  const factory ApiException.noConnection(
    @nullable int code,
    @nullable String printableMessage,
  ) = NoConnection;

  const factory ApiException.badRequest(
    int code,
    @nullable String printableMessage,
  ) = BadRequest;

  const factory ApiException.notFound(
    int code,
    @nullable String printableMessage,
  ) = NotFound;

  const factory ApiException.internalServerError(
    int code,
    @nullable String printableMessage,
  ) = InternalServerError;

  const factory ApiException.unknownError(
    @nullable int code,
    @nullable String printableMessage,
  ) = UnknownError;
}
