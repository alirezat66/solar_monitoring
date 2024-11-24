import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_chart/monitoring_chart.dart';
import 'package:monitoring_core/monitoring_core.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChartConfig', () {
    late ChartConfig chartConfig;
    late IntervalModel mockInterval;

    setUp(() {
      // Create a mock interval for testing
      mockInterval = IntervalModel.createNiceIntervals(
        lowerBound: 0,
        upperBound: 100,
      );
    });

    testWidgets('buildTitlesData generates correct configuration',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [ChartTheme.light],
        ),
        home: Builder(
          builder: (context) {
            chartConfig = ChartConfig(
              context,
              leftInterval: mockInterval,
              minX: 0,
              maxX: 86400,
              unit: PowerUnit.watts,
            );
            return Container();
          },
        ),
      ));

      final titlesData = chartConfig.buildTitlesData();

      // Test bottom titles
      expect(titlesData.bottomTitles, isA<AxisTitles>());
      expect(titlesData.bottomTitles.sideTitles.showTitles, true);
      expect(titlesData.bottomTitles.sideTitles.interval, 86400 / 4);

      // Test left titles
      expect(titlesData.leftTitles, isA<AxisTitles>());
      expect(titlesData.leftTitles.sideTitles.showTitles, true);
      expect(titlesData.leftTitles.sideTitles.reservedSize, 56);
      expect(titlesData.leftTitles.sideTitles.interval, mockInterval.interval);

      // Test axis name
      final axisNameWidget = titlesData.leftTitles.axisNameWidget as Text;
      expect(axisNameWidget.data, PowerUnit.watts.symbol);

      // Test disabled titles
      expect(titlesData.topTitles.drawBelowEverything, false);
      expect(titlesData.rightTitles.drawBelowEverything, false);
    });

    testWidgets('buildTouchData generates correct configuration',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData.light().copyWith(
          extensions: [ChartTheme.light],
        ),
        home: Builder(
          builder: (context) {
            chartConfig = ChartConfig(
              context,
              leftInterval: mockInterval,
              unit: PowerUnit.watts,
            );
            return Container();
          },
        ),
      ));

      final lineTouchData = chartConfig.buildTouchData();

      // Test basic configuration
      expect(lineTouchData, isA<LineTouchData>());
      expect(lineTouchData.enabled, true);
      expect(lineTouchData.touchTooltipData.tooltipPadding,
          const EdgeInsets.all(4));
    });

    group('custom configurations', () {
      testWidgets('supports different time ranges',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [ChartTheme.light],
          ),
          home: Builder(
            builder: (context) {
              chartConfig = ChartConfig(
                context,
                leftInterval: mockInterval,
                minX: 3600, // 1 hour
                maxX: 7200, // 2 hours
              );
              return Container();
            },
          ),
        ));

        final titlesData = chartConfig.buildTitlesData();
        expect(
            titlesData.bottomTitles.sideTitles.interval, 900); // (7200-3600)/4
      });

      testWidgets('supports different power units',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: [ChartTheme.light],
          ),
          home: Builder(
            builder: (context) {
              chartConfig = ChartConfig(
                context,
                leftInterval: mockInterval,
                unit: PowerUnit.kilowatts,
              );
              return Container();
            },
          ),
        ));

        final titlesData = chartConfig.buildTitlesData();
        final axisNameWidget = titlesData.leftTitles.axisNameWidget as Text;
        expect(axisNameWidget.data, PowerUnit.kilowatts.symbol);
      });
    });
  });
}
