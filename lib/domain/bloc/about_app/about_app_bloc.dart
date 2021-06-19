import 'package:auto_localized/auto_localized.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/entity/license/license.dart';
import 'package:weather_station/domain/utils/license/license_provider.dart';

part 'about_app_bloc.freezed.dart';
part 'about_app_event.dart';
part 'about_app_state.dart';

@injectable
class AboutAppBloc extends CustomBloc<AboutAppEvent, AboutAppState> {
  final LicenseProvider licenseProvider;

  AboutAppBloc(this.licenseProvider) : super(const RenderItems());

  @override
  Future<void> onEvent(AboutAppEvent event) async {
    await event.map(
      iconsClicked: _mapIconsClicked,
      packagesClicked: _mapPackagesClicked,
    );
  }

  Future<void> _mapIconsClicked(
    IconsClicked event,
  ) async {
    final licenses = await licenseProvider.getIconsLicenses();
    emit(PushLicenseListScreen(
      title: Strings.aboutAppIconsItem,
      licenses: licenses,
    ));
    emit(const Nothing());
  }

  Future<void> _mapPackagesClicked(
    PackagesClicked event,
  ) async {
    final licenses = await licenseProvider.getPackagesLicenses();
    emit(PushLicenseListScreen(
      title: Strings.aboutAppPackagesItem,
      licenses: licenses,
    ));
    emit(const Nothing());
  }
}
