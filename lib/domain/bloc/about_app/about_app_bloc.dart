import 'package:auto_route/auto_route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
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
      onIconsClicked: _mapOnIconsClicked,
      onPackagesClicked: _mapOnPackagesClicked,
    );
  }

  Future<void> _mapOnIconsClicked(
    OnIconsClicked event,
  ) async {}

  Future<void> _mapOnPackagesClicked(
    OnPackagesClicked event,
  ) async {
    final licenses = await licenseProvider.getPackagesLicenses();
    appNavigator.pushLicenseListScreen(
      title: Strings.aboutAppPackagesItem,
      licenses: licenses,
    );
  }
}
