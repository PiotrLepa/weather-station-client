part of 'fcm_bloc.dart';

@freezed
abstract class FcmEvent with _$FcmEvent implements BlocEvent {
  const factory FcmEvent.created() = Created;
}
