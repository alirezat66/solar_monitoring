import 'package:fl_chart/fl_chart.dart';
import 'package:solar_monitoring/core/theme/chart_theme_extension.dart';

class ChartGridConfig {
  final ChartThemeExtension theme;

  const ChartGridConfig({required this.theme});

  FlGridData buildGridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      getDrawingHorizontalLine: (_) => FlLine(
        color: theme.horizontalGridLineColor,
        strokeWidth: theme.horizontalGridLineWidth,
      ),
    );
  }
}
