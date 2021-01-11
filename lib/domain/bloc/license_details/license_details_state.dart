part of 'license_details_bloc.dart';

@freezed
abstract class LicenseDetailsState
    with _$LicenseDetailsState
    implements BlocState {
  const factory LicenseDetailsState.renderPage() = RenderPage;
}
