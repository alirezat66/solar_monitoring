import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/core/extensions/monitoring_model_extension.dart';

void main() {
  group('MonitoringModelExtension', () {
    test('calculates seconds from midnight correctly', () {
      final model = MonitoringModel(
        date: DateTime(2024, 1, 1, 10, 30, 15), // 10:30:15
        value: 100,
      );

      // 10 hours * 3600 + 30 minutes * 60 + 15 seconds = 37815
      expect(model.secondsFromMidnight, equals(37815));
    });

    test('converts to FlSpot correctly', () {
      final model = MonitoringModel(
        date: DateTime(2024, 1, 1, 10, 30, 15),
        value: 100,
      );

      final spot = model.spot;
      expect(spot.x, equals(37815.0)); // secondsFromMidnight as double
      expect(spot.y, equals(100.0)); // value as double
    });

    test('handles midnight correctly', () {
      final model = MonitoringModel(
        date: DateTime(2024, 1, 1, 0, 0, 0),
        value: 100,
      );

      expect(model.secondsFromMidnight, equals(0));
    });

    test('handles end of day correctly', () {
      final model = MonitoringModel(
        date: DateTime(2024, 1, 1, 23, 59, 59),
        value: 100,
      );

      expect(model.secondsFromMidnight, equals(86399));
    });
  });
}
