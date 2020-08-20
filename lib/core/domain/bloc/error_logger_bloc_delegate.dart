import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/common/logger/logger.dart';

class ErrorLoggerBlocDelegate extends BlocObserver {
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    logger.e(cubit, error, stackTrace);
    return super.onError(cubit, error, stackTrace);
  }
}
