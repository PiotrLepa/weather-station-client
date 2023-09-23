import 'package:flutter/material.dart';

class CurrentWeatherAppBarCorners extends StatelessWidget {
  const CurrentWeatherAppBarCorners({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.of(context).appBarTheme.backgroundColor,
        height: 20,
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            border: Border.all(
              color: Theme.of(context).colorScheme.background,
              width: 0,
            ),
          ),
        ),
      ),
    );
  }
}
