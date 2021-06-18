part of 'license_list_bloc.dart';

@freezed
class LicenseListEvent with _$LicenseListEvent implements BlocEvent {
  const factory LicenseListEvent.licenseClicked(License item) = LicenseClicked;

  const factory LicenseListEvent.linkClicked(String url) = LinkClicked;
}
