import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/core/presentation/validation/validators.dart';
import 'package:weather_station/core/presentation/widgets/form/app_field_form.dart';
import 'package:weather_station/domain/bloc/configure_station/configure_station_bloc.dart';
import 'package:weather_station/domain/entity/wifi/wifi.dart';
import 'package:weather_station/domain/entity/wifi_credentials/wifi_credentials.dart';

class WifiPasswordInputDialog extends StatefulWidget {
  final Wifi wifi;

  const WifiPasswordInputDialog({
    Key key,
    @required this.wifi,
  }) : super(key: key);

  @override
  _WifiPasswordInputDialogState createState() =>
      _WifiPasswordInputDialogState();
}

class _WifiPasswordInputDialogState extends State<WifiPasswordInputDialog> {
  final _passwordFormKey = GlobalKey<AppFormFieldState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Strings.wifiPasswordDialogTitle.get(context)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppFormField(
            key: _passwordFormKey,
            labelText: Strings.wifiPasswordInputLabel,
            validators: [Validators.required],
            obscureText: true,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            appNavigator.pop();
          },
          child: Text(Strings.dialogCancel.get(context)),
        ),
        FlatButton(
          onPressed: () {
            if (_passwordFormKey.currentState.validate()) {
              appNavigator.pop();
              final credentials = WifiCredentials(
                name: widget.wifi.name,
                password: _passwordFormKey.currentState.value,
              );
              context
                  .read<ConfigureStationBloc>()
                  .add(OnPasswordInserted(credentials));
            }
          },
          child: Text(Strings.connect.get(context)),
        )
      ],
    );
  }
}
