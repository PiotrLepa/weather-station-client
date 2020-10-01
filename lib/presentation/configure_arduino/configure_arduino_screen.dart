import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/widgets/error/error_page.dart';
import 'package:weather_station/domain/bloc/configure_arduino/configure_arduino_bloc.dart';
import 'package:weather_station/presentation/configure_arduino/widgets/configure_arduino_connecting.dart';
import 'package:weather_station/presentation/configure_arduino/widgets/configure_arduino_wifi_inputs.dart';

class ConfigureArduinoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<ConfigureArduinoBloc>()..add(const OnScreenStarted()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<ConfigureArduinoBloc, ConfigureArduinoState>(
          listener: (context, state) {
            state.maybeMap(
              showPermissionInfoDialog: (_) {
                _showPermissionInfoDialog(context);
              },
              orElse: () {},
            );
          },
          buildWhen: (oldState, newState) =>
              newState is Connecting ||
              newState is RenderWifiInputs ||
              newState is RenderError,
          builder: (context, state) {
            return state.maybeMap(
              connecting: (s) => ConfigureArduinoConnecting(),
              renderWifiInputs: (s) => ConfigureArduinoWifiInputs(),
              renderError: (s) => ErrorPage(
                onRetry: () {
                  context
                      .bloc<ConfigureArduinoBloc>()
                      .add(const OnRetryClicked());
                },
                message: s.message,
                loading: s.loading,
              ),
              orElse: () => Container(),
            );
          },
        ),
      ),
    );
  }

  void _showPermissionInfoDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(Strings.permissionInfoDialogTitle.get(context)),
        content: Text(Strings.permissionInfoDialogMessage.get(context)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              appNavigator.pop();
            },
            child: Text(Strings.dialogCancel.get(context)),
          ),
          FlatButton(
            onPressed: () {
              appNavigator.pop();
              context.bloc<ConfigureArduinoBloc>().add(
                  const OnPermissionDialogPositiveClicked());
            },
            child: Text(Strings.dialogOk.get(context)),
          )
        ],
      ),
    );
  }
}
