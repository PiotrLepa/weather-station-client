import 'package:flutter/material.dart';

Future<T> showAppModalBottomSheet<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
}) =>
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: builder,
    );
