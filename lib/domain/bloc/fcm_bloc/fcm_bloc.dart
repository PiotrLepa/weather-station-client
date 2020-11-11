import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/flushbar_helper.dart';
import 'package:weather_station/core/common/logger/logger.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/core/extension/string_extension.dart';
import 'package:weather_station/domain/repository/fcm_repository.dart';

part 'fcm_bloc.freezed.dart';

part 'fcm_event.dart';

part 'fcm_state.dart';

@injectable
class FcmBloc extends CustomBloc<FcmEvent, FcmState> {
  final FcmRepository _notificationRepository;
  final FlushbarHelper _flushbarHelper;

  FcmBloc(
    this._notificationRepository,
    this._flushbarHelper,
  ) : super(const Empty()) {
    _notificationRepository.getRainDetected().handleError(
      (Object error) {
        logger.d('error');
      },
    ).listen((notification) {
      _flushbarHelper.showNotification(
        message: notification.body.toLocalized(),
      );
    });
  }

  @override
  Future<void> onEvent(FcmEvent event) async {}
}
