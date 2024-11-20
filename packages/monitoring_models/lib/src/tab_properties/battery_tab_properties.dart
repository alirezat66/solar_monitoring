import 'package:flutter/material.dart';
import 'package:monitoring_models/src/tab_properties/tab_properties.dart';

class BatteryTabProperties implements TabProperties {
  @override
  String get title => 'Battery';

  @override
  IconData get icon => Icons.battery_std;
}
