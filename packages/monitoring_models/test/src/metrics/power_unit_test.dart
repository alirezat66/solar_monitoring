import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_models/src/metrics/power_unit.dart';

void main() {
  group('PowerUnit', () {
    test('watts has correct values', () {
      expect(PowerUnit.watts.symbol, equals('W'));
      expect(PowerUnit.watts.conversion, equals(1));
    });

    test('kilowatts has correct values', () {
      expect(PowerUnit.kilowatts.symbol, equals('kW'));
      expect(PowerUnit.kilowatts.conversion, equals(0.001));
    });
  });
}
