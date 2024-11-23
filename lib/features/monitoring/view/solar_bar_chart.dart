import 'package:flutter/material.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:monitoring_models/monitoring_models.dart';

class MonitoringChart extends StatelessWidget {
  final List<MonitoringModel> data;

  const MonitoringChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: context.chartTheme.chartAspectRatio,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: EnergyLineChart(
          data: data,
          unit: PowerUnit.kilowatts,
          maxX: 4 * 3600,
          minX: 1 * 3600,
        ),
      ),
    );
  }
}
