import 'package:flutter/material.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/state/monitoring_state_selector.dart';

class MonitoringTabView extends StatelessWidget {
  const MonitoringTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: EnergyType.values.map((type) {
        return MonitoringStateSelector(type: type);
      }).toList(),
    );
  }
}
