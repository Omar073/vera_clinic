bool isLastWednesdayOfMonth(DateTime date) {
  final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
  return date.weekday == DateTime.wednesday &&
      date.day > lastDayOfMonth.day - 7;
}
