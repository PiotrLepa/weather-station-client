import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/about_app/about_app_bloc.dart';
import 'package:weather_station/presentation/home/settings/widget/settings_item.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<AboutAppBloc>(),
      child: Scaffold(
        body: BlocBuilder<AboutAppBloc, AboutAppState>(
          builder: (context, state) {
            return state.map(renderItems: (s) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(Strings.aboutAppItem.get(context)),
                ),
                body: _buildPage(context),
              );
            });
          },
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          SettingsItem(
            name: Strings.aboutAppIconsItem,
            onPressed: () {
              context.bloc<AboutAppBloc>().add(const OnIconsClicked());
            },
          ),
          SettingsItem(
            name: Strings.aboutAppPackagesItem,
            onPressed: () {
              context.bloc<AboutAppBloc>().add(const OnPackagesClicked());
            },
          ),
        ],
      ),
    );
  }
}
