import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_station/core/domain/bloc/bloc_event.dart';
import 'package:weather_station/core/domain/bloc/bloc_state.dart';
import 'package:weather_station/core/domain/bloc/custom_bloc.dart';
import 'package:weather_station/domain/entity/license/license.dart';

part 'license_details_bloc.freezed.dart';

part 'license_details_event.dart';

part 'license_details_state.dart';

@injectable
class LicenseDetailsBloc
    extends CustomBloc<LicenseDetailsEvent, LicenseDetailsState> {
  LicenseDetailsBloc() : super(const RenderPage());

  @override
  Future<void> onEvent(LicenseDetailsEvent event) async {}
}
