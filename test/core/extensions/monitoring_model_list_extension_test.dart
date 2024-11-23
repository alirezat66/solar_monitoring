import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/core/extensions/monitoring_model_list_extension.dart';

void main() {
  group('MonitoringModelListExtension', () {
    test('calculates correct minY from list', () {
      final data = [
        MonitoringModel(date: DateTime.now(), value: 100),
        MonitoringModel(date: DateTime.now(), value: 50),
        MonitoringModel(date: DateTime.now(), value: 75),
      ];

      expect(data.minY, equals(50.0));
    });

    test('calculates correct maxY from list', () {
      final data = [
        MonitoringModel(date: DateTime.now(), value: 100),
        MonitoringModel(date: DateTime.now(), value: 50),
        MonitoringModel(date: DateTime.now(), value: 75),
      ];

      expect(data.maxY, equals(100.0));
    });

    test('throws when list is empty', () {
      final List<MonitoringModel> data = [];

      expect(() => data.minY, throwsStateError);
      expect(() => data.maxY, throwsStateError);
    });

    test('handles single item list', () {
      final data = [MonitoringModel(date: DateTime.now(), value: 100)];

      expect(data.minY, equals(100.0));
      expect(data.maxY, equals(100.0));
    });

    test('handles negative values', () {
      final data = [
        MonitoringModel(date: DateTime.now(), value: -100),
        MonitoringModel(date: DateTime.now(), value: -50),
        MonitoringModel(date: DateTime.now(), value: -75),
      ];

      expect(data.minY, equals(-100.0));
      expect(data.maxY, equals(-50.0));
    });
  });
}
