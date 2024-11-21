import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/core/extensions/context_extension.dart';
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
            lineBarsData: [
              LineChartBarData(
                spots: chartData.spots,
                isCurved: true,
                color: theme.lineColor,
                barWidth: theme.lineWidth,
                curveSmoothness: theme.curveSmoothness,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: theme.areaGradient,
                ),
              ),
            ],
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (_) => FlLine(
                color: theme.horizontalGridLineColor,
                strokeWidth: theme.horizontalGridLineWidth,
              ),
            ),
            borderData: theme.borderData,
            titlesData: _buildTitlesData(context),
            lineTouchData: _buildTouchData(context),
          ),
        ),
      ),
    );
  }

  FlTitlesData _buildTitlesData(BuildContext context) {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, _) => Text(
            value.toHourMinuteString(),
            style: context.textTheme.bodySmall,
          ),
          interval: 4 * 3600,
        ),
      ),
      topTitles: const AxisTitles(drawBelowEverything: false),
      rightTitles: const AxisTitles(drawBelowEverything: false),
    );
  }

  LineTouchData _buildTouchData(BuildContext context) {
    final theme = context.chartTheme;
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        tooltipPadding: const EdgeInsets.all(4),
        getTooltipColor: (_) => theme.dotMainColor,
        getTooltipItems: (spots) => spots
            .map((spot) => LineTooltipItem(
                  '${spot.x.toHourMinuteString()}\n${spot.y.toString()}',
                  context.textTheme.labelMedium!.copyWith(
                    color: theme.lineColor,
                    fontWeight: FontWeight.bold,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
