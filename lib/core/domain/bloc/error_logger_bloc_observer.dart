import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/logger/logger.dart';

@lazySingleton
class ErrorLoggerBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e(bloc, error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
