import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:monitoring_models/src/tab_properties/battery_tab_properties.dart';
import 'package:monitoring_models/src/tab_properties/house_tab_properties.dart';
import 'package:monitoring_models/src/tab_properties/solar_tab_properties.dart';

void main() {
  group('EnergyType Tab Properties', () {
    test('Solar properties are correct', () {
      final properties = EnergyType.solar.properties;
      expect(properties, isA<SolarTabProperties>());
      expect(properties.title, equals('Solar'));
      expect(properties.icon, equals(Icons.solar_power));
    });

    test('House properties are correct', () {
      final properties = EnergyType.house.properties;
      expect(properties, isA<HouseTabProperties>());
      expect(properties.title, equals('House'));
      expect(properties.icon, equals(Icons.house));
    });

    test('Battery properties are correct', () {
      final properties = EnergyType.battery.properties;
      expect(properties, isA<BatteryTabProperties>());
      expect(properties.title, equals('Battery'));
      expect(properties.icon, equals(Icons.battery_std));
    });

    group('TabProperties implementations', () {
      test('SolarTabProperties', () {
        final properties = SolarTabProperties();
        expect(properties.title, equals('Solar'));
        expect(properties.icon, equals(Icons.solar_power));
      });


      test('BatteryTabProperties', () {
        final properties = BatteryTabProperties();
        expect(properties.title, equals('Battery'));
        expect(properties.icon, equals(Icons.battery_std));
      });
    });
  });
}
