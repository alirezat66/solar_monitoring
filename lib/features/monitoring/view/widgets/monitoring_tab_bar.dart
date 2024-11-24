import 'package:flutter/material.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

class MonitoringTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MonitoringTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: EnergyType.values.map((type) {
        final properties = type.properties;
        return Tab(
          text: properties.title,
          icon: Icon(properties.icon),
        );
      }).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
