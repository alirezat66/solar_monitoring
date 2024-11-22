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
      expect(wattsValue.format(), equals('1000.00 W'));

      const kwValue = PowerValue(
        valueInWatts: 1000,
        unit: PowerUnit.kilowatts,
      );
      expect(kwValue.format(), equals('1.00 kW'));
    });

    test('converts between units', () {
      const watts = PowerValue(valueInWatts: 1000);
      final kw = watts.convertTo(PowerUnit.kilowatts);

      expect(kw.displayValue, equals(1));
      expect(kw.unit, equals(PowerUnit.kilowatts));
    });
  });
}
