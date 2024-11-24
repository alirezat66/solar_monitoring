import 'package:flutter/material.dart';
import 'tab_properties.dart';

class BatteryTabProperties implements TabProperties {
  @override
  String get title => 'Battery';

  @override
  IconData get icon => Icons.battery_std;
}
