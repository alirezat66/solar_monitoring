
import 'package:monitoring_core/src/models/energy/energy_type.dart';

extension EnergyTabPropertiesExtension on EnergyType {
  TabProperties get properties => switch (this) {
        EnergyType.solar => SolarTabProperties(),
        EnergyType.house => HouseTabProperties(),
        EnergyType.battery => BatteryTabProperties(),
      };
}
