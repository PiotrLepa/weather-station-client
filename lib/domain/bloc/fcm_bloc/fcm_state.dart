part of 'fcm_bloc.dart';

@freezed
abstract class FcmState with _$FcmState implements BlocState {
  const factory FcmState.empty() = Empty;
}
