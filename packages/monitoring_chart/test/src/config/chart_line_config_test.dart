import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:monitoring_chart/src/config/chart_line_config.dart';

void main() {
  group('ChartLineConfig Tests', () {
    late ChartLineConfig chartLineConfig;

    test('Test ChartLineConfig LineData generation', () {
      final theme = ChartTheme.light;
      const spots = [
        FlSpot(0, 1),
        FlSpot(1, 3),
        FlSpot(2, 5),
      ];
      chartLineConfig =  ChartLineConfig(spots: spots, theme: theme);

      final lineData = chartLineConfig.buildLineData();
      expect(lineData, isA<LineChartBarData>());
      expect(lineData.spots, spots);
      expect(lineData.isCurved, true);
      expect(lineData.color, theme.lineColor);
      expect(lineData.barWidth, theme.lineWidth);
      expect(lineData.curveSmoothness, theme.curveSmoothness);
      expect(lineData.dotData.show, false);
      expect(lineData.belowBarData.show, true);
      expect(lineData.belowBarData.gradient, theme.areaGradient);
    });
  });
}
