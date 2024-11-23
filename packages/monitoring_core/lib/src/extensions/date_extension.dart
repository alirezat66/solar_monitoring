extension DateExtension on DateTime {
  /// Formats the current [DateTime] instance into a `YYYY-MM-DD` string.

  String get formattedDate =>
      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}
