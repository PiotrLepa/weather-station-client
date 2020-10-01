import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/logger/logger.dart';

@lazySingleton
class ErrorLoggerCubitObserver extends BlocObserver {
  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    logger.e(cubit, error, stackTrace);
    return super.onError(cubit, error, stackTrace);
  }
}
