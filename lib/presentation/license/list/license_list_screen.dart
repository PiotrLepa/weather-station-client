import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/settings/settings_bloc.dart';
import 'package:weather_station/domain/entity/license/license.dart';

class LicenseListScreen extends StatelessWidget {
  final KtList<License> licences;

  const LicenseListScreen({
    Key key,
    @required this.licences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<SettingsBloc>(),
      child: Scaffold(
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(Strings.aboutAppItem.get(context)),
              ),
              body: _buildPage(context),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
        itemCount: licences.size,
        itemBuilder: (context, index) {
          return Text(licences[index].name);
        },
      ),
    );
  }
}
