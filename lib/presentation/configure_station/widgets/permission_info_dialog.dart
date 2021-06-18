import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/common/router/routing.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/configure_station/configure_station_bloc.dart';

class PermissionInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(Strings.permissionInfoDialogTitle.get(context)),
      content: Text(Strings.permissionInfoDialogMessage.get(context)),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            context.router.pop();
          },
          child: Text(Strings.dialogCancel.get(context)),
        ),
        FlatButton(
          onPressed: () {
            context.router.pop();
            context
                .read<ConfigureStationBloc>()
                .add(const PermissionDialogPositiveClicked());
          },
          child: Text(Strings.dialogOk.get(context)),
        )
      ],
    );
  }
}
