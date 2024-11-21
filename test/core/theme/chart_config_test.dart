import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solar_monitoring/core/theme/chart_config.dart';
import 'package:solar_monitoring/core/theme/light_theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChartConfig Tests', () {
    late ChartConfig chartConfig;

    testWidgets('Test ChartConfig bottom titles generation',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: lightTheme,
        home: Builder(
          builder: (context) {
            chartConfig = ChartConfig(context);
            return Container();
          },
        ),
      ));

      final titlesData = chartConfig.buildTitlesData();
      expect(titlesData.bottomTitles, isA<AxisTitles>());
      expect(titlesData.bottomTitles.sideTitles.showTitles, true);
      expect(titlesData.bottomTitles.sideTitles.interval, 4 * 3600);
    });

    testWidgets('Test ChartConfig LineTouchData generation',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: lightTheme,
        home: Builder(
          builder: (context) {
            chartConfig = ChartConfig(context);
            return Container();
          },
        ),
      ));

      final lineTouchData = chartConfig.buildTouchData();
      expect(lineTouchData, isA<LineTouchData>());
      expect(lineTouchData.enabled, true);
      expect(lineTouchData.touchTooltipData.tooltipPadding,
          const EdgeInsets.all(4));
    });
  });
}
