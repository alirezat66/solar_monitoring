import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_core/monitoring_core.dart';
import 'package:monitoring_models/monitoring_models.dart';
import '../extensions/context_extension.dart';

class ChartConfig {
  final BuildContext context;
  final double minX;
  final double maxX;
  final double timeInterval;
  final PowerUnit unit;
  const ChartConfig(
    this.context, {
    this.minX = 0,
    this.maxX = 86400,
    this.timeInterval = 4 * 3600,
    this.unit = PowerUnit.watts,
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
          interval: (maxX - minX) / 4,
        ),
      ),
      leftTitles: AxisTitles(
        axisNameSize: 32,
        axisNameWidget: Text(unit.symbol,
            style: context.textTheme.labelLarge!
                .copyWith(fontWeight: FontWeight.bold)),
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 56,
          getTitlesWidget: (value, _) => Text(
            PowerValue(
              valueInWatts: value,
              unit: unit,
            ).format(),
            style: context.textTheme.bodySmall,
          ),
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
        getTooltipItems: (spots) => spots.map((spot) {
          final power = PowerValue(valueInWatts: spot.y, unit: unit);
          return LineTooltipItem(
            '${spot.x.toHourMinuteString()}\n${power.format()}',
            context.textTheme.labelMedium!.copyWith(
              color: theme.lineColor,
              fontWeight: FontWeight.bold,
            ),
          );
        }).toList(),
      ),
    );
  }
}
