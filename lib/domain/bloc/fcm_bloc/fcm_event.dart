part of 'fcm_bloc.dart';

@freezed
class FcmEvent with _$FcmEvent implements BlocEvent {
  const factory FcmEvent.created() = Created;
}
