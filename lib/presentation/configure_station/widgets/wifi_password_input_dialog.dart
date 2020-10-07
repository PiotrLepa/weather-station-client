import 'package:flutter/material.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/domain/bloc/configure_station/configure_station_bloc.dart';

class WifiPasswordInputDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            context
                .bloc<ConfigureStationBloc>()
                .add(const OnPermissionDialogPositiveClicked());
          },
          child: Text(Strings.dialogOk.get(context)),
        )
      ],
    );
  }
}
