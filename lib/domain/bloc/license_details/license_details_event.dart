part of 'license_details_bloc.dart';

@freezed
abstract class LicenseDetailsEvent
    with _$LicenseDetailsEvent
    implements BlocEvent {
  const factory LicenseDetailsEvent.nothing() = Nothing;
}
