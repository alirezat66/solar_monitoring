import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_models/src/metrics/power_unit.dart';
import 'package:monitoring_models/src/metrics/power_value.dart';

void main() {
  group('PowerValue', () {
    test('creates with watts by default', () {
      const power = PowerValue(valueInWatts: 1000);
      expect(power.unit, equals(PowerUnit.watts));
      expect(power.displayValue, equals(1000));
    });

    test('converts to kilowatts correctly', () {
      const power = PowerValue(
        valueInWatts: 1000,
        unit: PowerUnit.kilowatts,
      );
      expect(power.displayValue, equals(1));
    });

    test('formats value correctly', () {
      const wattsValue = PowerValue(valueInWatts: 1000);
      expect(wattsValue.format(), equals('1000'));

      const kwValue = PowerValue(
        valueInWatts: 1000,
        unit: PowerUnit.kilowatts,
      );
      expect(kwValue.format(), equals('1'));
    });

    test('converts between units', () {
      const watts = PowerValue(valueInWatts: 1000);
      final kw = watts.convertTo(PowerUnit.kilowatts);

      expect(kw.displayValue, equals(1));
      expect(kw.unit, equals(PowerUnit.kilowatts));
    });
  });

  group('PowerValue formatting', () {
    test('formats whole numbers without decimals', () {
      const value = PowerValue(valueInWatts: 750);
      expect(value.format(), equals('750'));
    });

    test('formats single decimal place correctly', () {
      const value = PowerValue(valueInWatts: 750.5);
      expect(value.format(), equals('750.5'));
    });

    test('formats two decimal places correctly', () {
      const value = PowerValue(valueInWatts: 750.51);
      expect(value.format(), equals('750.51'));
    });

    test('removes trailing zeros after decimal', () {
      const value1 = PowerValue(valueInWatts: 750.10);
      expect(value1.format(), equals('750.1'));

      const value2 = PowerValue(valueInWatts: 750.00);
      expect(value2.format(), equals('750'));
    });

    test('handles very small numbers correctly', () {
      const value = PowerValue(
        valueInWatts: 0.01,
        unit: PowerUnit.kilowatts,
      );
      expect(value.format(), equals('0'));
    });
    test('handles very small numbers correctly', () {
      const value = PowerValue(
        valueInWatts: 0.01,
        unit: PowerUnit.watts,
      );
      expect(value.format(), equals('0.01'));
    });

    test('handles large numbers correctly', () {
      const value = PowerValue(valueInWatts: 1000000);
      expect(value.format(), equals('1000000'));
    });
  });
}
