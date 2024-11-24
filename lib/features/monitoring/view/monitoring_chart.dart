import 'package:flutter/material.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:monitoring_core/monitoring_core.dart';

class MonitoringChart extends StatelessWidget {
  final List<MonitoringModel> data;
  final PowerUnit unit;
  const MonitoringChart({
    super.key,
    required this.data,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(
          aspectRatio:
              MediaQuery.orientationOf(context) == Orientation.landscape
                  ? context.chartTheme.chartAspectRatioLandscape
                  : context.chartTheme.chartAspectRatioPortrait,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
            child: EnergyLineChart(
              data: data,
              unit: unit,
            ),
          ),
        ),
      ],
    );
  }
}
