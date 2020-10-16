part of 'license_list_bloc.dart';

@freezed
abstract class LicenseListEvent with _$LicenseListEvent implements BlocEvent {
  const factory LicenseListEvent.onLicenseClicked(License item) =
      OnLicenseClicked;
}
