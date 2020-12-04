import 'package:flutter/material.dart';

Future<void> showHourlyWeatherDayPicker(BuildContext context,
    List<DateTime> availableDays,
    Function(DateTime) onDateSelected,) async {
  final selectedDate = await showDatePicker(
      context: context,
      initialDate: availableDays.last,
      firstDate: availableDays.first,
      lastDate: availableDays.last,
      selectableDayPredicate: (date) => availableDays.contains(date));

  if (selectedDate != null) {
    onDateSelected(selectedDate);
  }
}
