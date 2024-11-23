import 'package:flutter/material.dart';
import 'package:monitoring_models/src/tab_properties/tab_properties.dart';

class SolarTabProperties implements TabProperties {
  @override
  String get title => 'Solar';

  @override
  IconData get icon => Icons.solar_power;
}
