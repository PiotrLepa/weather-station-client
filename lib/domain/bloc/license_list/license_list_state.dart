part of 'license_list_bloc.dart';

@freezed
class LicenseListState with _$LicenseListState implements BlocState {
  const factory LicenseListState.nothing() = Nothing;

  const factory LicenseListState.renderItems() = RenderItems;

  const factory LicenseListState.pushLicenseDetails({
    required License license,
  }) = PushLicenseDetails;
}
