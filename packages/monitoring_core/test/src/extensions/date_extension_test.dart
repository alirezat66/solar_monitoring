import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_core/monitoring_core.dart';

void main() {
  group('DateTimeExtension', () {
    test('should format date correctly with single digit month and day', () {
      final date = DateTime(2024, 1, 5);
      expect(date.formattedDate, '2024-01-05');
    });

    test('should format date correctly with double digit month and day', () {
      final date = DateTime(2024, 12, 25);
      expect(date.formattedDate, '2024-12-25');
    });

    test('should format date correctly with mixed single and double digits',
        () {
      final date = DateTime(2024, 12, 1);
      expect(date.formattedDate, '2024-12-01');

      final anotherDate = DateTime(2024, 1, 15);
      expect(anotherDate.formattedDate, '2024-01-15');
    });

    test('should return true if the date is today', () {
      final today = DateTime.now();
      expect(today.isToday, isTrue);
    });

    test('should return false if the date is not today', () {
      final notToday = DateTime(2000, 1, 1);
      expect(notToday.isToday, isFalse);
    });
  });
}
