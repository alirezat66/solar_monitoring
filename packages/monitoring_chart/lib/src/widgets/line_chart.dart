import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:monitoring_chart/src/config/chart_grid_config.dart';
import 'package:monitoring_chart/src/config/chart_line_config.dart';
import 'package:monitoring_models/monitoring_models.dart';

class SolarLineChart extends StatelessWidget {
  final List<MonitoringModel> data;
  final int minX;
  final int maxY;
  const SolarLineChart({
    super.key,
    required this.data,
    this.minX = 0,
    this.maxY = 86400,
  });

  @override
  Widget build(BuildContext context) {
    final chartData = ChartData.fromMonitoringModelList(data);
    final theme = context.chartTheme;
    final config = ChartConfig(context);
    final lineConfig = ChartLineConfig(spots: chartData.spots, theme: theme);
    final gridConfig = ChartGridConfig(theme: theme);

    return LineChart(
      LineChartData(
        minY: chartData.interval.lowerBound,
        maxY: chartData.interval.upperBound,
        minX: minX.toDouble(),
        maxX: maxY.toDouble(),
        lineBarsData: [lineConfig.buildLineData()],
        gridData: gridConfig.buildGridData(),
        borderData: theme.borderData,
        titlesData: config.buildTitlesData(),
        lineTouchData: config.buildTouchData(),
      ),
    );
  }
}
