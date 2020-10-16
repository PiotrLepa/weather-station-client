import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kt_dart/collection.dart';
import 'package:weather_station/core/presentation/widgets/common/rounded_divider.dart';
import 'package:weather_station/domain/bloc/license_list/license_list_bloc.dart';
import 'package:weather_station/domain/entity/license/license.dart';
import 'package:weather_station/presentation/license/list/widgets/license_item.dart';

class LicenseList extends StatelessWidget {
  final KtList<License> licenses;

  const LicenseList({
    Key key,
    @required this.licenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: licenses.size,
      itemBuilder: (context, index) {
        final item = licenses[index];
        return InkWell(
          onTap: () {
            context.bloc<LicenseListBloc>().add(OnLicenseClicked(item));
          },
          child: LicenseItem(name: item.name),
        );
      },
      separatorBuilder: (context, index) {
        return const RoundedDivider(
          thickness: 1,
          size: 1,
        );
      },
    );
  }
}
