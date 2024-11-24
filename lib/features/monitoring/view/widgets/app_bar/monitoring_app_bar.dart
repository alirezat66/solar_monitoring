import 'package:flutter/material.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/app_bar/monitoring_app_bar_title.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/monitoring_tab_bar.dart';

class MonitoringAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MonitoringAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const MonitoringAppBarTitle(),
      bottom: const MonitoringTabBar(),
      toolbarHeight: 100,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(148); // toolbarHeight + tabHeight
}
