extension NumExtension on num {
  /// Converts a numerical value representing seconds into an `HH:mm` formatted string.
  String toHourMinuteString() {
    final hours = this ~/ 3600;
    final minutes = (this % 3600) ~/ 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  /// Converts the number to a string representation with a given number of decimal places.
  /// Trailing zeros are removed if unnecessary.
  ///
  /// [decimals] - The number of decimal places (defaults to 2).
  String formatValue([int decimals = 2]) {
    final String stringValue = toStringAsFixed(decimals);
    final List<String> parts = stringValue.split('.');

    if (parts.length == 1) {
      return parts[0];
    }
    if (parts[1].replaceAll('0', '').isEmpty) {
      return parts[0];
    }

    if (parts[1].endsWith('0')) {
      return '${parts[0]}.${parts[1].substring(0, 1)}';
    }
    return stringValue;
  }
}
