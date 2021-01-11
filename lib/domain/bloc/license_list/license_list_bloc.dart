import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/domain/entity/license/license.dart';

part 'license_list_bloc.freezed.dart';
part 'license_list_event.dart';
part 'license_list_state.dart';

@injectable
class LicenseListBloc extends CustomBloc<LicenseListEvent, LicenseListState> {
  LicenseListBloc() : super(const RenderItems());

  @override
  Future<void> onEvent(LicenseListEvent event) async {
    await event.map(
      licenseClicked: _mapLicenseClicked,
      linkClicked: _mapLinkClicked,
    );
  }

  Future<void> _mapLicenseClicked(
    LicenseClicked event,
  ) async {
    if (event.item.details != null) {
      emit(PushLicenseDetails(license: event.item));
    }
  }

  Future<void> _mapLinkClicked(
    LinkClicked event,
  ) async {
    if (await canLaunch(event.url)) {
      await launch(event.url);
    }
  }
}
