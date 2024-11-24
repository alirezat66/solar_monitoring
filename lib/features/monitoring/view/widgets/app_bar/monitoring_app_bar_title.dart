import 'package:flutter/material.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/app_bar/date_selector.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/app_bar/theme_mode_toggle.dart';
import 'package:solar_monitoring/features/monitoring/view/widgets/unit_selector.dart';

class MonitoringAppBarTitle extends StatelessWidget {
  const MonitoringAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            DateSelector(),
            ThemeModeToggle(),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: UnitSelector(),
        ),
      ],
    );
  }
}
