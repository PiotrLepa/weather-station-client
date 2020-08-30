import 'package:flutter/material.dart';

class HomeAppBarCorners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.of(context).appBarTheme.color,
        height: 20,
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
            ),
            border: Border.all(
              color: Theme.of(context).backgroundColor,
              width: 0,
            ),
          ),
        ),
      ),
    );
  }
}
