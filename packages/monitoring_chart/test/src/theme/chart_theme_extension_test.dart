import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChartThemeExtension Tests', () {
    test('Test ChartThemeExtension copyWith method', () {
      final theme = ChartTheme.light;
      final copiedTheme = theme.copyWith(lineColor: Colors.red);

      expect(copiedTheme.lineColor, Colors.red);
      expect(
          copiedTheme.horizontalGridLineColor, theme.horizontalGridLineColor);
      expect(copiedTheme.dotMainColor, theme.dotMainColor);
    });

    test('Test ChartThemeExtension lerp method', () {
      final lightTheme = ChartTheme.light;
      final darkTheme = ChartTheme.dark;
      final changedTheme =
          lightTheme.lerp(darkTheme, 0.5) as ChartThemeExtension;

      expect(changedTheme.lineColor,
          Color.lerp(lightTheme.lineColor, darkTheme.lineColor, 0.5));
      expect(
          changedTheme.horizontalGridLineColor,
          Color.lerp(lightTheme.horizontalGridLineColor,
              darkTheme.horizontalGridLineColor, 0.5));
      expect(changedTheme.dotMainColor,
          Color.lerp(lightTheme.dotMainColor, darkTheme.dotMainColor, 0.5));
    });

    test('Test ChartThemeExtension horizontalGridLine method', () {
      final theme = ChartTheme.light;
      final horizontalGridLine = theme.horizontalGridLine;

      expect(horizontalGridLine.color, theme.horizontalGridLineColor);
      expect(horizontalGridLine.strokeWidth, theme.horizontalGridLineWidth);
    });

    test('Test ChartThemeExtension verticalGridLine method', () {
      final theme = ChartTheme.light;
      final verticalGridLine = theme.verticalGridLine;

      expect(verticalGridLine.color, theme.verticalGridLineColor);
      expect(verticalGridLine.strokeWidth, theme.verticalGridLineWidth);
      expect(verticalGridLine.dashArray, theme.verticalLineDashPattern);
    });

    test('Test ChartThemeExtension borderData method', () {
      final theme = ChartTheme.light;
      final borderData = theme.borderData;

      expect(borderData.show, true);
      expect(borderData.border.bottom, theme.chartBorder);
    });

    test('Test ChartThemeExtension copyWith method for lineColor', () {
      final theme = ChartTheme.light;
      final copiedTheme = theme.copyWith(lineColor: Colors.red);

      expect(copiedTheme.lineColor, Colors.red);
      expect(
          copiedTheme.horizontalGridLineColor, theme.horizontalGridLineColor);
      expect(copiedTheme.verticalGridLineColor, theme.verticalGridLineColor);
      expect(copiedTheme.chartBorder, theme.chartBorder);
      expect(copiedTheme.dotMainColor, theme.dotMainColor);
      expect(copiedTheme.dotBorderColor, theme.dotBorderColor);
      expect(copiedTheme.dotSecondaryColor, theme.dotSecondaryColor);
      expect(copiedTheme.filterSelectedColor, theme.filterSelectedColor);
      expect(copiedTheme.filterUnselectedColor, theme.filterUnselectedColor);
      expect(copiedTheme.areaGradient, theme.areaGradient);
    });

    test('Test ChartThemeExtension copyWith method handles null values', () {
      final theme = ChartTheme.light;
      final copiedTheme = theme.copyWith(); // Not passing any parameters

      expect(
          copiedTheme.lineColor, theme.lineColor); // Should keep original value
      expect(
          copiedTheme.horizontalGridLineColor, theme.horizontalGridLineColor);
      expect(copiedTheme.verticalGridLineColor, theme.verticalGridLineColor);
    });

// Or more specifically for lineColor
    test('Test ChartThemeExtension copyWith method with null lineColor', () {
      final theme = ChartTheme.light;
      final copiedTheme =
          theme.copyWith(lineColor: null); // Explicitly passing null

      expect(
          copiedTheme.lineColor, theme.lineColor); // Should keep original value
    });
  });
}
