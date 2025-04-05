import 'package:intl/intl.dart';

int getWeekOfMonth(DateTime date) {
  final firstDayOfMonth = DateTime(date.year, date.month, 1);
  final daysSinceFirst = date.day + firstDayOfMonth.weekday - 1;
  return (daysSinceFirst / 7).ceil().clamp(1, 4);
}

String getDateText(DateTime date) {
  return DateFormat('dd/MM/yyyy').format(date);
}