import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_core/src/models/metrics/metric_unit.dart';
import 'package:monitoring_core/src/models/metrics/power_unit.dart';

class TestMetricUnit extends MetricUnit {
  const TestMetricUnit() : super(symbol: 'Test', conversion: 1.0);
}

void main() {
  group('PowerUnit', () {
    test('watts has correct values', () {
      expect(PowerUnit.watts.symbol, equals('Watts'));
      expect(PowerUnit.watts.conversion, equals(1));
    });

    test('kilowatts has correct values', () {
      expect(PowerUnit.kilowatts.symbol, equals('kWatts'));
      expect(PowerUnit.kilowatts.conversion, equals(0.001));
    });
    test('implements MetricUnit correctly', () {
      // This implicitly tests the MetricUnit abstract class
      const unit = PowerUnit.watts;
      expect(unit, isA<MetricUnit>());
      expect(unit.symbol, isA<String>());
      expect(unit.conversion, isA<double>());
    });
    test('MetricUnit base class works correctly', () {
      const unit = TestMetricUnit();
      expect(unit.symbol, 'Test');
      expect(unit.conversion, 1.0);
    });
  });
}
