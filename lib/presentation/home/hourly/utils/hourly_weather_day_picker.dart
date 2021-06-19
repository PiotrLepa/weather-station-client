import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';

Future<void> showHourlyWeatherDayPicker(
  BuildContext context,
  KtList<DateTime> availableDays,
  Function(DateTime) onDateSelected, {
  DateTime? initialDate,
}) async {
  final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? availableDays.last(),
      firstDate: availableDays.first(),
      lastDate: availableDays.last(),
      selectableDayPredicate: (date) => availableDays.contains(date));

  if (selectedDate != null) {
    onDateSelected(selectedDate);
  }
}
