import 'package:flutter/material.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/tab/monitoring_tab_view.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/app_bar/monitoring_app_bar.dart';

class MonitoringView extends StatelessWidget {
  const MonitoringView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: EnergyType.values.length,
      child: const Scaffold(
        appBar: MonitoringAppBar(),
        body: MonitoringTabView(),
      ),
    );
  }
}
