import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChartThemeExtension Tests', () {
    test('Test ChartThemeExtension light theme properties', () {
      const theme = ChartThemeExtension.light;

      expect(theme.lineColor, const Color(0xFF3B3A3A));
      expect(theme.horizontalGridLineColor, const Color(0xFFE5E5E5));
      expect(theme.verticalGridLineColor, const Color(0xFF3B3A3A));
      expect(theme.chartBorder, isA<BorderSide>());
      expect(theme.chartBorder.color, const Color(0xFFE5E5E5));
      expect(theme.chartBorder.width, 1);
      expect(theme.dotMainColor, const Color(0xFF3B3A3A));
      expect(theme.dotBorderColor, const Color(0xFF3B3A3A));
      expect(theme.dotSecondaryColor, const Color(0xFF898989));
      expect(theme.filterSelectedColor, const Color(0xFFECECEC));
      expect(theme.filterUnselectedColor, const Color(0xFFECECEC));
      expect(theme.areaGradient, isA<LinearGradient>());
      expect(theme.areaGradient!.colors.length, 3);
    });

    test('Test ChartThemeExtension dark theme properties', () {
      const theme = ChartThemeExtension.dark;

      expect(theme.lineColor, const Color(0xFFE5E5E5));
      expect(theme.horizontalGridLineColor, const Color(0xFF3B3A3A));
      expect(theme.verticalGridLineColor, const Color(0xFFE5E5E5));
      expect(theme.chartBorder, isA<BorderSide>());
      expect(theme.chartBorder.color, const Color(0xFF3B3A3A));
      expect(theme.chartBorder.width, 1);
      expect(theme.dotMainColor, const Color(0xFFE5E5E5));
      expect(theme.dotBorderColor, const Color(0xFFE5E5E5));
      expect(theme.dotSecondaryColor, const Color(0xFF959393));
      expect(theme.filterSelectedColor, const Color(0xFF3B3A3A));
      expect(theme.filterUnselectedColor, const Color(0xFF3B3A3A));
      expect(theme.areaGradient, isA<LinearGradient>());
      expect(theme.areaGradient!.colors.length, 3);
    });

    test('Test ChartThemeExtension copyWith method', () {
      const theme = ChartThemeExtension.light;
      final copiedTheme = theme.copyWith(lineColor: Colors.red);

      expect(copiedTheme.lineColor, Colors.red);
      expect(
          copiedTheme.horizontalGridLineColor, theme.horizontalGridLineColor);
      expect(copiedTheme.dotMainColor, theme.dotMainColor);
    });

    test('Test ChartThemeExtension lerp method', () {
      const lightTheme = ChartThemeExtension.light;
      const darkTheme = ChartThemeExtension.dark;
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
  });
}
