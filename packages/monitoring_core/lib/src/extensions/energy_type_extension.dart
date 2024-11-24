
import 'package:monitoring_core/src/models/energy/energy_type.dart';
import 'package:monitoring_core/src/models/tab_properties/battery_tab_properties.dart';
import 'package:monitoring_core/src/models/tab_properties/house_tab_properties.dart';
import 'package:monitoring_core/src/models/tab_properties/solar_tab_properties.dart';
import 'package:monitoring_core/src/models/tab_properties/tab_properties.dart';

extension EnergyTabPropertiesExtension on EnergyType {
  TabProperties get properties => switch (this) {
        EnergyType.solar => SolarTabProperties(),
        EnergyType.house => HouseTabProperties(),
        EnergyType.battery => BatteryTabProperties(),
      };
}
