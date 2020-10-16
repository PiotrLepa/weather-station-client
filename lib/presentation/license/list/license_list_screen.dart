import 'package:auto_localized/auto_localized.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/domain/bloc/license_list/license_list_bloc.dart';
import 'package:weather_station/domain/entity/license/license.dart';
import 'package:weather_station/presentation/license/list/widgets/license_list.dart';

class LicenseListScreen extends StatelessWidget {
  final PlainLocalizedString title;
  final KtList<License> licenses;

  const LicenseListScreen({
    Key key,
    @required this.title,
    @required this.licenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<LicenseListBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title.get(context)),
        ),
        body: BlocBuilder<LicenseListBloc, LicenseListState>(
          builder: (context, state) {
            return state.map(
              renderItems: (_) {
                return LicenseList(licenses: licenses);
              },
            );
          },
        ),
      ),
    );
  }
}
