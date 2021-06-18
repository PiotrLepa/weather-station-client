import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/locale_provider.dart';
import 'package:weather_station/core/data/network/network_constant.dart';

@lazySingleton
class LanguageInterceptor extends InterceptorsWrapper {
  final LocaleProvider _localeProvider;

  LanguageInterceptor(this._localeProvider);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final headers = options.headers;
    headers[acceptLanguageHeader] = _localeProvider.currentLanguageCode;

    super.onRequest(options, handler);
  }
}
