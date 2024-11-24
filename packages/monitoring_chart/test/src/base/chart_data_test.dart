import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:monitoring_core/monitoring_core.dart';

void main() {
  group('ChartData', () {
    test('creates from empty list', () {
      final chartData = ChartData.fromMonitoringModelList([]);

      expect(chartData.models, isEmpty);
      expect(chartData.minY, equals(0));
      expect(chartData.maxY, equals(0));
      expect(chartData.spots, isEmpty);
      expect(chartData.interval.interval, equals(0));
      expect(chartData.interval.lowerBound, equals(0));
      expect(chartData.interval.upperBound, equals(0));
    });

    test('creates from single model', () {
      final models = [
        MonitoringModel(
          date: DateTime(2024, 1, 1, 12), // 12:00:00
          value: 100,
        ),
      ];

      final chartData = ChartData.fromMonitoringModelList(models);

      expect(chartData.models, equals(models));
      expect(chartData.minY, equals(100));
      expect(chartData.maxY, equals(100));
      expect(chartData.spots.length, equals(1));
      expect(chartData.spots.first.x, equals(43200)); // 12 hours in seconds
      expect(chartData.spots.first.y, equals(100));
    });

    test('calculates correct interval bounds for multiple models', () {
      final models = [
        MonitoringModel(
          date: DateTime(2024, 1, 1, 10), // 10:00:00
          value: 100,
        ),
        MonitoringModel(
          date: DateTime(2024, 1, 1, 14), // 14:00:00
          value: 500,
        ),
      ];

      final chartData = ChartData.fromMonitoringModelList(models);

      expect(
          chartData.interval.lowerBound, lessThanOrEqualTo(99)); // 100 * 0.99
      expect(chartData.interval.upperBound,
          greaterThanOrEqualTo(505)); // 500 * 1.01
      expect(chartData.interval.interval, isPositive);
    });

    test('maintains chronological spot order', () {
      final models = [
        MonitoringModel(
          date: DateTime(2024, 1, 1, 14), // 14:00:00
          value: 200,
        ),
        MonitoringModel(
          date: DateTime(2024, 1, 1, 10), // 10:00:00
          value: 100,
        ),
      ];

      final chartData = ChartData.fromMonitoringModelList(models);
      final spots = chartData.spots;

      expect(spots[0].x, equals(50400)); // 14 hours in seconds
      expect(spots[0].y, equals(200));
      expect(spots[1].x, equals(36000)); // 10 hours in seconds
      expect(spots[1].y, equals(100));
    });

    test('handles negative values', () {
      final models = [
        MonitoringModel(
          date: DateTime(2024, 1, 1, 12),
          value: -100,
        ),
        MonitoringModel(
          date: DateTime(2024, 1, 1, 13),
          value: -50,
        ),
      ];

      final chartData = ChartData.fromMonitoringModelList(models);

      expect(chartData.minY, equals(-100));
      expect(chartData.maxY, equals(-50));
      expect(chartData.interval.lowerBound, lessThanOrEqualTo(-100));
      expect(chartData.interval.upperBound, greaterThanOrEqualTo(-50));
    });

    test('converts time to seconds correctly', () {
      final models = [
        MonitoringModel(
          date: DateTime(2024, 1, 1, 12, 30, 15), // 12:30:15
          value: 100,
        ),
      ];

      final chartData = ChartData.fromMonitoringModelList(models);
      final spot = chartData.spots.first;

      // 12 hours * 3600 + 30 minutes * 60 + 15 seconds = 45015
      expect(spot.x, equals(45015));
      expect(spot.y, equals(100));
    });

    test('handles identical values', () {
      final models = [
        MonitoringModel(
          date: DateTime(2024, 1, 1, 12),
          value: 100,
        ),
        MonitoringModel(
          date: DateTime(2024, 1, 1, 13),
          value: 100,
        ),
      ];

      final chartData = ChartData.fromMonitoringModelList(models);

      expect(chartData.minY, equals(100));
      expect(chartData.maxY, equals(100));
      expect(chartData.interval.interval,
          isPositive); // Should still have valid interval
    });
  });
}
