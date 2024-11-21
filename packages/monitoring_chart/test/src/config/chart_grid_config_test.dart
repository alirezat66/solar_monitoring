import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:monitoring_chart/src/config/chart_grid_config.dart';

void main() {
  group('ChartGridConfig Tests', () {
    late ChartGridConfig chartGridConfig;

    test('Test ChartGridConfig GridData generation', () {
      const theme = ChartThemeExtension.light;
      chartGridConfig = const ChartGridConfig(theme: theme);

      final gridData = chartGridConfig.buildGridData();
      expect(gridData, isA<FlGridData>());
      expect(gridData.show, true);
      expect(gridData.drawVerticalLine, false);
      final horizontalLine = gridData.getDrawingHorizontalLine(0);
      expect(horizontalLine.color, theme.horizontalGridLineColor);
      expect(horizontalLine.strokeWidth, theme.horizontalGridLineWidth);
    });
  });
}
