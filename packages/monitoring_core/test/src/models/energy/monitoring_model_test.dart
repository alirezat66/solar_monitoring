// test/features/monitoring/models/monitoring_model_test.dart
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_core/src/models/energy/monitoring_model.dart';

import '../../../fixtures/fixture_reader.dart';


void main() {
  group('MonitoringModel', () {
    test('should create MonitoringModel from JSON correctly', () {
      // Arrange
      final json = {'timestamp': '2024-10-17T00:00:00.000Z', 'value': 2758};

      // Act
      final result = MonitoringModel.fromJson(json);

      // Assert
      expect(result, isA<MonitoringModel>());
      expect(result.date, DateTime.parse('2024-10-17T00:00:00.000Z'));
      expect(result.value, 2758);
    });

    test('should parse list of monitoring data from fixture', () async {
      // Arrange
      final List<dynamic> jsonList =
          json.decode(fixture('monitoring_response.json'));

      // Act
      final result =
          jsonList.map((json) => MonitoringModel.fromJson(json)).toList();

      // Assert
      expect(result, isA<List<MonitoringModel>>());
      expect(result.length, 288); // 24 hours * 12 (5-minute intervals)

      // Check first item
      expect(result.first.date, DateTime.parse('2024-10-17T00:00:00.000Z'));
      expect(result.first.value, 2758);

      // Check last item
      expect(result.last.date, DateTime.parse('2024-10-17T23:55:00.000Z'));
      expect(result.last.value, 6969);
    });

    test('should handle different numeric value types', () {
      // Arrange
      final jsonInt = {'timestamp': '2024-10-17T00:00:00.000Z', 'value': 100};
      final jsonDouble = {
        'timestamp': '2024-10-17T00:00:00.000Z',
        'value': 100.5
      };

      // Act
      final resultInt = MonitoringModel.fromJson(jsonInt);
      final resultDouble = MonitoringModel.fromJson(jsonDouble);

      // Assert
      expect(resultInt.value, isA<num>());
      expect(resultDouble.value, isA<num>());
      expect(resultInt.value, 100);
      expect(resultDouble.value, 100.5);
    });
  });
}
