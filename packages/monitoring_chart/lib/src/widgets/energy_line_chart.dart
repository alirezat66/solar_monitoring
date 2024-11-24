import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:monitoring_chart/src/config/chart_grid_config.dart';
import 'package:monitoring_chart/src/config/chart_line_config.dart';
import 'package:monitoring_core/monitoring_core.dart';

class EnergyLineChart extends StatelessWidget {
  final List<MonitoringModel> data;
  final double minX;
  final double maxX;
  final PowerUnit unit;

  const EnergyLineChart({
    super.key,
    required this.data,
    this.minX = 0,
    this.maxX = 86400,
    this.unit = PowerUnit.watts,
  });

  @override
  Widget build(BuildContext context) {
    final chartData = ChartData.fromMonitoringModelList(data,
        displayUnit: unit, minX: minX, maxX: maxX);
    final theme = context.chartTheme;
    final config = ChartConfig(
      context,
      minX: minX,
      maxX: maxX,
      unit: unit,
      leftInterval: chartData.interval,
    );
    final lineConfig = ChartLineConfig(spots: chartData.spots, theme: theme);
    final gridConfig = ChartGridConfig(theme: theme);

    return LineChart(
      LineChartData(
        minY: chartData.interval.lowerBound,
        maxY: chartData.interval.upperBound,
        minX: minX.toDouble(),
        maxX: maxX.toDouble(),
        lineBarsData: [lineConfig.buildLineData()],
        gridData: gridConfig.buildGridData(),
        borderData: theme.borderData,
        titlesData: config.buildTitlesData(),
        lineTouchData: config.buildTouchData(),
      ),
    );
  }
}
