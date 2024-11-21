import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:solar_monitoring/core/theme/chart_theme_extension.dart';

class ChartConfig {
  final BuildContext context;
  final ChartThemeExtension theme;

  const ChartConfig({
    required this.context,
    required this.theme,
  });

  LineChartBarData getLineBarData(List<FlSpot> spots) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: theme.lineColor,
      barWidth: theme.lineWidth,
      isStrokeCapRound: false,
      curveSmoothness: 0.2,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: theme.areaGradient,
      ),
    );
  }

  FlGridData get gridData => FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (_) => theme.horizontalGridLine,
      );
}
