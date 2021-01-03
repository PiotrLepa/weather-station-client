import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/presentation/widgets/error/error_page.dart';
import 'package:weather_station/domain/bloc/configure_station/configure_station_bloc.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/presentation/configure_station/widgets/connecting_to_station.dart';
import 'package:weather_station/presentation/configure_station/widgets/connecting_to_wifi_dialog.dart';
import 'package:weather_station/presentation/configure_station/widgets/permission_info_dialog.dart';
import 'package:weather_station/presentation/configure_station/widgets/wifi_list_page.dart';
import 'package:weather_station/presentation/configure_station/widgets/wifi_password_input_dialog.dart';

class ConfigureStationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConfigureStationBloc, ConfigureStationState>(
      listener: (context, state) {
        state.maybeMap(
          showPermissionInfoDialog: (_) {
            _showPermissionInfoDialog(context);
          },
          showWifiPasswordInputDialog: (s) {
            _showWifiPasswordInputDialog(context, s.wifi);
          },
          showConnectingToWifiDialog: (_) {
            _showConnectingToWifiDialog(context);
          },
          orElse: () {},
        );
      },
      buildWhen: (oldState, newState) =>
          newState is Connecting ||
          newState is RenderWifiList ||
          newState is RenderError,
      builder: (context, state) {
        return state.maybeMap(
          connecting: (s) => ConnectingToStation(),
          renderWifiList: (s) => WifiListPage(wifiList: s.wifiList),
          renderError: (s) => ErrorPage(
            onRetry: () {
              context.read<ConfigureStationBloc>().add(const OnRetryClicked());
            },
            message: s.message,
            loading: s.loading,
          ),
          orElse: () => const SizedBox(),
        );
      },
    );
  }

  void _showPermissionInfoDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<ConfigureStationBloc>(),
        child: PermissionInfoDialog(),
      ),
    );
  }

  void _showWifiPasswordInputDialog(
    BuildContext context,
    Wifi wifi,
  ) {
    showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<ConfigureStationBloc>(),
        child: WifiPasswordInputDialog(
          wifi: wifi,
        ),
      ),
    );
  }

  void _showConnectingToWifiDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: BlocProvider.value(
          value: context.read<ConfigureStationBloc>(),
          child: ConnectingToWifiDialog(),
        ),
      ),
    );
  }
}
