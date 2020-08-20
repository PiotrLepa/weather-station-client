library paged_call_state;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_station/core/common/raw_key_string.dart';

part 'paged_call_state.freezed.dart';

@freezed
abstract class PagedCallState<T> with _$PagedCallState<T> {
  const factory PagedCallState.initialProgress() = InitialProgress<T>;

  const factory PagedCallState.initialSuccess(T result) = InitialSuccess<T>;

  const factory PagedCallState.initialError(RawKeyString errorMessage) =
      InitialError<T>;

  const factory PagedCallState.additionalProgress() = AdditionalProgress<T>;

  const factory PagedCallState.additionalSuccess(T result) =
      AdditionalSuccess<T>;

  const factory PagedCallState.additionalError(RawKeyString errorMessage) =
      AdditionalError<T>;
}
