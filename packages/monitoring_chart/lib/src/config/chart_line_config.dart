import 'package:fl_chart/fl_chart.dart';
import '../theme/chart_theme_extension.dart';

class ChartLineConfig {
  final List<FlSpot> spots;
  final ChartThemeExtension theme;

  const ChartLineConfig({
    required this.spots,
    required this.theme,
  });

  LineChartBarData buildLineData() {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: theme.lineColor,
      barWidth: theme.lineWidth,
      curveSmoothness: theme.curveSmoothness,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        gradient: theme.areaGradient,
      ),
    );
  }
}
