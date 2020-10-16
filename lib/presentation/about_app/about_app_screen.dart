import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_station/core/injection/injection.dart';
import 'package:weather_station/core/presentation/language/strings.al.dart';
import 'package:weather_station/domain/bloc/about_app/about_app_bloc.dart';
import 'package:weather_station/presentation/about_app/widget/about_app_list.dart';

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
                body: AboutAppList(),
              );
            });
          },
        ),
      ),
    );
  }
}
