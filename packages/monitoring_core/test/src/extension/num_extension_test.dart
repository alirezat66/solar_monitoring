import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_core/monitoring_core.dart';

void main() {
  group('NumExtension toHourMinuteString', () {
    test('Correctly converts seconds to hours and minutes (exact hours)', () {
      expect(3600.toHourMinuteString(), '01:00');
      expect(7200.toHourMinuteString(), '02:00');
      expect(10800.toHourMinuteString(), '03:00');
    });

    test('Correctly converts seconds to hours and minutes (hours and minutes)',
        () {
      expect(3660.toHourMinuteString(), '01:01');
      expect(7260.toHourMinuteString(), '02:01');
      expect(10920.toHourMinuteString(), '03:02');
    });

    test('Correctly converts seconds to hours and minutes (less than an hour)',
        () {
      expect(0.toHourMinuteString(), '00:00');
      expect(60.toHourMinuteString(), '00:01');
      expect(3599.toHourMinuteString(), '00:59');
    });

    test('Handles edge cases correctly', () {
      expect(0.toHourMinuteString(), '00:00');
      expect(1.toHourMinuteString(), '00:00');
      expect(59.toHourMinuteString(), '00:00');
      expect(61.toHourMinuteString(), '00:01');
    });

    test('Handles large values correctly', () {
      expect(36000.toHourMinuteString(), '10:00');
      expect(86399.toHourMinuteString(), '23:59');
      expect(86400.toHourMinuteString(), '24:00'); // 24 hours
    });
  });

  group('NumExtension formatValue', () {
    test('should format number with two decimal places by default', () {
      expect(1234.5678.formatValue(), '1234.57');
    });

    test('should format integer number with two decimal places by default', () {
      expect(1234.formatValue(), '1234');
    });

    test('should format number with specified decimal places', () {
      expect(1234.5678.formatValue(3), '1234.568');
    });

    test('should format number with trailing zeros removed', () {
      expect(1234.50.formatValue(), '1234.5');
    });

    test('should format number with no decimal places', () {
      expect(1234.0.formatValue(), '1234');
    });
  });
}
