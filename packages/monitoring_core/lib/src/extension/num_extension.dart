extension NumExtension on num {
  String toHourMinuteString() {
    final hours = this ~/ 3600;
    final minutes = (this % 3600) ~/ 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  String formatValue([int decimals = 2]) {
    final String stringValue = toStringAsFixed(decimals);
    final List<String> parts = stringValue.split('.');

    // If decimal part is all zeros, return just the integer part
    if (parts[1].replaceAll('0', '').isEmpty) {
      return parts[0];
    }

    // If decimal part ends with 0, remove it
    if (parts[1].endsWith('0')) {
      return '${parts[0]}.${parts[1].substring(0, 1)}';
    }
    return stringValue;
  }
}
