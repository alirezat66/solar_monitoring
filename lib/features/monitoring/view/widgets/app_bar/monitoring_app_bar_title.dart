import 'package:flutter/material.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/app_bar/date_selector.dart';
import 'package:solar_monitoring/features/theme/view/theme_mode_toggle.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/tab/unit_selector.dart';

class MonitoringAppBarTitle extends StatelessWidget {
  const MonitoringAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DateSelector(),
            ThemeModeToggle(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 16),
          child: UnitSelector(),
        ),
      ],
    );
  }
}
