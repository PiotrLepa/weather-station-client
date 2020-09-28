part of 'configure_arduino_bloc.dart';

@freezed
abstract class ConfigureArduinoEvent with _$ConfigureArduinoEvent {
  const factory ConfigureArduinoEvent.updateConnectingImage() =
      UpdateConnectingImage;
}
