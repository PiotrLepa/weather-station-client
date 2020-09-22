import 'package:flutter/cupertino.dart';
import 'package:weather_station/core/common/logger/logger.dart';
import 'package:weather_station/core/data/network/exception/api/api_exception.dart';
import 'package:weather_station/core/domain/call_state/call_state.dart';
import 'package:weather_station/core/domain/call_state/pagination/paged_call_state.dart';
import 'package:weather_station/core/domain/error/error_translator.dart';
import 'package:weather_station/core/injection/injection.dart';

Stream<CallState<T>> callApi<T>(
  Future<T> call,
) async* {
  try {
    yield const CallState.progress();
    final result = await call;
    yield CallState.success(result);
  } on ApiException catch (e) {
    final errorMessage = getIt.get<ErrorTranslator>().translate(e);
    yield CallState.error(errorMessage);
  } catch (e, s) {
    logger.e('bloc helper fetch', e, s);
  }
}

Stream<PagedCallState<T>> callPagedApi<T>({
  @required Future<T> call,
  @required int page,
}) async* {
  try {
    if (page == 0) {
      yield const PagedCallState.initialProgress();
    } else {
      yield const PagedCallState.additionalProgress();
    }
    final result = await call;
    if (page == 0) {
      yield PagedCallState.initialSuccess(result);
    } else {
      yield PagedCallState.additionalSuccess(result);
    }
  } on ApiException catch (e) {
    final errorMessage = getIt.get<ErrorTranslator>().translate(e);
    if (page == 0) {
      yield PagedCallState.initialError(errorMessage);
    } else {
      yield PagedCallState.additionalError(errorMessage);
    }
  } catch (e, s) {
    logger.e('bloc helper fetch', e, s);
  }
}
