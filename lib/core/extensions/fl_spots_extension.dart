import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:solar_monitoring/features/monitoring/model/interval_model.dart';
import 'package:solar_monitoring/features/monitoring/view/chart_style.dart';

extension FlSpotsExtension on List<FlSpot> {
  IntervalModel get verticalInterval => IntervalModel.fromSpots(this);

  double get maxY =>
      fold<double>(0, (max, spot) => spot.y > max ? spot.y : max);
  double get minY =>
      fold<double>(double.infinity, (min, spot) => spot.y < min ? spot.y : min);

  List<LineChartBarData> getLineBarData(BuildContext context) {
    return [
      LineChartBarData(
        spots: this,
        isCurved: true,
        color: Theme.of(context).primaryColor,
        barWidth: 1,
        isStrokeCapRound: false,
        curveSmoothness: 0.2,
        dotData: const FlDotData(show: false), // Remove dots here

        belowBarData:
            BarAreaData(show: true, gradient: ChartStyle.chartLinearGradient),
      ),
    ];
  }

  FlGridData get flGridData => FlGridData(
      show: true,
      drawVerticalLine: false,
      getDrawingHorizontalLine: (value) {
        return ChartStyle.flHorizontalLine;
      });
}
