import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/core/extensions/context_extension.dart';
import 'package:solar_monitoring/core/theme/chart_config.dart';
import 'package:solar_monitoring/core/theme/chart_grid_config.dart';
import 'package:solar_monitoring/core/theme/chart_line_config.dart';
import 'package:solar_monitoring/features/monitoring/model/chart_data_model.dart';

class MonitoringChart extends StatelessWidget {
  final List<MonitoringModel> data;

  const MonitoringChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final chartData = ChartData.fromMonitoringModelList(data);
    final theme = context.chartTheme;
    final config = ChartConfig(context);
    final lineConfig = ChartLineConfig(spots: chartData.spots, theme: theme);
    final gridConfig = ChartGridConfig(theme: theme);

    return AspectRatio(
      aspectRatio: theme.chartAspectRatio,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
        child: LineChart(
          LineChartData(
            minY: chartData.interval.lowerBound,
            maxY: chartData.interval.upperBound,
            minX: 0,
            maxX: 86400,
            lineBarsData: [lineConfig.buildLineData()],
            gridData: gridConfig.buildGridData(),
            borderData: theme.borderData,
            titlesData: config.buildTitlesData(),
            lineTouchData: config.buildTouchData(),
          ),
        ),
      ),
    );
  }
}
