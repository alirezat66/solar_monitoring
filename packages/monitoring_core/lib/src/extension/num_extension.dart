extension NumExtension on num {
  String toHourMinuteString() {
    final hours = this ~/ 3600;
    final minutes = (this % 3600) ~/ 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}
