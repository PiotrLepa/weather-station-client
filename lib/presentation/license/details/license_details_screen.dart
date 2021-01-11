import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/domain/bloc/license_details/license_details_bloc.dart';
import 'package:weather_station/domain/entity/license/license.dart';
import 'package:weather_station/presentation/license/details/widgets/license_details_page.dart';

class LicenseDetailsScreen extends StatelessWidget {
  final License license;

  const LicenseDetailsScreen({
    Key key,
    @required this.license,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<LicenseDetailsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(license.name),
        ),
        body: BlocBuilder<LicenseDetailsBloc, LicenseDetailsState>(
          builder: (context, state) {
            return state.map(
              renderPage: (_) {
                return LicenseDetailsPage(content: license.details);
              },
            );
          },
        ),
      ),
    );
  }
}
