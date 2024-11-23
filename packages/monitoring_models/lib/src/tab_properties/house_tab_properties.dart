import 'package:flutter/material.dart';
import 'package:monitoring_models/src/tab_properties/tab_properties.dart';

class HouseTabProperties implements TabProperties {
  @override
  String get title => 'House';

  @override
  IconData get icon => Icons.house;
}
