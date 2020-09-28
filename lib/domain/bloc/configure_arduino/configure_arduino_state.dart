part of 'configure_arduino_bloc.dart';

@freezed
abstract class ConfigureArduinoState with _$ConfigureArduinoState {
  const factory ConfigureArduinoState.loading(SvgGenImage image) = Loading;
}
