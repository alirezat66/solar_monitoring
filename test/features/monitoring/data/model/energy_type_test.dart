import 'package:flutter_test/flutter_test.dart';
import 'package:solar_monitoring/features/monitoring/data/model/energy_type.dart';

void main() {
  group('EnergyType', () {
    test('should have correct queryParam values', () {
      expect(EnergyType.solar.queryParam, 'solar');
      expect(EnergyType.house.queryParam, 'house');
      expect(EnergyType.battery.queryParam, 'battery');
    });
  });
}
