part of 'license_list_bloc.dart';

@freezed
abstract class LicenseListState with _$LicenseListState implements BlocState {
  const factory LicenseListState.renderItems() = RenderItems;

  const factory LicenseListState.pushLicenseDetails({
    @required License license,
  }) = PushLicenseDetails;
}
