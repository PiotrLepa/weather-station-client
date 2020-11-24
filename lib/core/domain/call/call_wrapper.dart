import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_station/core/common/logger/logger.dart';
import 'package:weather_station/core/data/network/exception/api/api_exception.dart';
import 'package:weather_station/core/domain/error/error_translator.dart';
import 'package:weather_station/core/injection/injection.dart';

Future<void> callWrapper<T>({
  @required Future<T> call,
  void Function() onProgress,
  void Function(T) onSuccess,
  void Function(Exception, PlainLocalizedString) onError,
}) async {
  try {
    onProgress?.call();
    final result = await call;
    onSuccess?.call(result);
  } on ApiException catch (e) {
    final errorMessage = getIt.get<ErrorTranslator>().translate(e);
    onError?.call(e, errorMessage);
  } on Exception catch (e) {
    final errorMessage = getIt.get<ErrorTranslator>().translate(e);
    onError?.call(e, errorMessage);
  } catch (e, s) {
    logger.e('call wrapper', e, s);
  }
}

Future<void> callPagedApi<T>({
  @required Future<T> call,
  @required int page,
  void Function() onInitialProgress,
  void Function(T) onInitialSuccess,
  void Function(PlainLocalizedString) onInitialError,
  void Function() onAdditionalProgress,
  void Function(T) onAdditionalSuccess,
  void Function(PlainLocalizedString) onAdditionalError,
}) async {
  try {
    if (page == 0) {
      onInitialProgress();
    } else {
      onAdditionalProgress();
    }
    final result = await call;
    if (page == 0) {
      onInitialSuccess(result);
    } else {
      onAdditionalSuccess(result);
    }
  } on ApiException catch (e) {
    final errorMessage = getIt.get<ErrorTranslator>().translate(e);
    if (page == 0) {
      onInitialError(errorMessage);
    } else {
      onAdditionalError(errorMessage);
    }
  } catch (e, s) {
    logger.e('paged call wrapper', e, s);
  }
}
