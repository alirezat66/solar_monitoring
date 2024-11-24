import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_core/monitoring_core.dart';

void main() {
  group('EnergyType', () {
    test('should have correct queryParam values', () {
      expect(EnergyType.solar.queryParam, 'solar');
      expect(EnergyType.house.queryParam, 'house');
      expect(EnergyType.battery.queryParam, 'battery');
    });
  });
}
