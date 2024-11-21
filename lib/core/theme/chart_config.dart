import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:solar_monitoring/core/extensions/context_extension.dart';

class ChartConfig {
  final BuildContext context;
  final double minX;
  final double maxX;
  final double timeInterval;

  const ChartConfig(
    this.context, {
    this.minX = 0,
    this.maxX = 86400,
    this.timeInterval = 4 * 3600,
  });

  FlTitlesData buildTitlesData() {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, _) => Text(
            value.toHourMinuteString(),
            style: context.textTheme.bodySmall,
          ),
          interval: timeInterval,
        ),
      ),
      topTitles: const AxisTitles(drawBelowEverything: false),
      rightTitles: const AxisTitles(drawBelowEverything: false),
    );
  }

  LineTouchData buildTouchData() {
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
