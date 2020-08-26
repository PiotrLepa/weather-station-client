// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../data/network/interceptor/connection_interceptor.dart';
import '../presentation/date_time/date_time_formatter.dart';
import '../domain/error/error_translator.dart';
import '../common/flushbar_helper.dart';
import '../data/network/interceptor/language_interceptor.dart';
import '../common/locale_provider.dart';
import '../data/network/interceptor/logger_interceptor.dart';
import '../common/serialization/model_decoder.dart';
import '../data/network/network_error_handler.dart';
import 'network_module.dart';
import '../data/network/serializer/response_converter.dart';
import '../domain/validation/validators.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final networkModule = _$NetworkModule();
  gh.lazySingleton<ConnectionInterceptor>(() => ConnectionInterceptor());
  gh.lazySingleton<Dio>(() => networkModule.dioDefault);
  gh.lazySingleton<ErrorTranslator>(() => ErrorTranslator());
  gh.lazySingleton<FlushbarHelper>(() => FlushbarHelper());
  gh.lazySingleton<LocaleProvider>(() => LocaleProvider());
  gh.lazySingleton<LoggerInterceptor>(() => LoggerInterceptor());
  gh.lazySingleton<ModelDecoder>(() => ModelDecoder());
  gh.lazySingleton<NetworkErrorHandler>(() => NetworkErrorHandler());
  gh.lazySingleton<ResponseConverter>(
      () => ResponseConverter(get<ModelDecoder>()));
  gh.lazySingleton<Validator>(() => Validator());
  gh.lazySingleton<DateTimeFormatter>(
      () => DateTimeFormatter(get<LocaleProvider>()));
  gh.lazySingleton<LanguageInterceptor>(
      () => LanguageInterceptor(get<LocaleProvider>()));
  return get;
}

class _$NetworkModule extends NetworkModule {}
