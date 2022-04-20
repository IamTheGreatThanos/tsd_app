extension StringExtensions on DateTime {
  DateTime fromTime(String time) {
    return DateTime.parse('2000-01-01T$time.000000');
  }

  bool isEquals(DateTime date) {
    return date.day == day &&
        date.month == month &&
        date.year == year;
  }
}

