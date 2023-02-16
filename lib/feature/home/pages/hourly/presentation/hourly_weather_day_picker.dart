import 'package:flutter/material.dart';

Future<void> showHourlyWeatherDayPicker(
  BuildContext context,
  List<DateTime> availableDays,
  Function(DateTime) onDateSelected, {
  DateTime? initialDate,
}) async {
  final selectedDate = await showDatePicker(
    context: context,
    initialDate: initialDate ?? availableDays.last,
    firstDate: availableDays.first,
    lastDate: availableDays.last,
    selectableDayPredicate: (date) => _isDateAvailable(availableDays, date),
  );

  if (selectedDate != null) {
    onDateSelected(selectedDate);
  }
}

bool _isDateAvailable(List<DateTime> availableDays, DateTime date) =>
    availableDays.any((availableDay) =>
        availableDay.year == date.year &&
        availableDay.month == date.month &&
        availableDay.day == date.day);
