import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:monitoring_chart/monitoring_chart.dart';

main() {
  group('ChartTheme Tests', () {
    test('Test ChartTheme light theme properties', () {
      final theme = ChartTheme.light;

      expect(theme.lineColor, const Color(0xFF2D3142));
      expect(theme.horizontalGridLineColor, const Color(0xFFE5E5E5));
      expect(theme.verticalGridLineColor, const Color(0xFFD3D3D3));
      expect(theme.chartBorder, isA<BorderSide>());
      expect(theme.chartBorder.color, const Color(0xFFE5E5E5));
      expect(theme.chartBorder.width, 1);
      expect(theme.dotMainColor, const Color(0xFFE5D9F6));
      expect(theme.dotBorderColor, Colors.white);
      expect(theme.dotSecondaryColor, const Color(0xFF4F5D75));
      expect(theme.filterSelectedColor, const Color(0xFF2D3142));
      expect(theme.filterUnselectedColor, const Color(0xFFE5E5E5));
      expect(theme.areaGradient, isA<LinearGradient>());
      expect(theme.areaGradient?.colors.length, 3);
    });

    test('Test ChartTheme dark theme properties', () {
      final theme = ChartTheme.dark;

      expect(theme.lineColor, const Color(0xFF61DAFB));
      expect(theme.horizontalGridLineColor, const Color(0xFF2C5364));
      expect(theme.verticalGridLineColor, const Color(0xFF203A43));
      expect(theme.chartBorder, isA<BorderSide>());
      expect(theme.chartBorder.color, const Color(0xFF2C5364));
      expect(theme.chartBorder.width, 1);
      expect(theme.dotMainColor, const Color(0xFF6200EE));
      expect(theme.dotBorderColor, Colors.black);
      expect(theme.dotSecondaryColor, const Color(0xFF2C5364));
      expect(theme.filterSelectedColor, const Color(0xFF61DAFB));
      expect(theme.filterUnselectedColor, const Color(0xFF203A43));
      expect(theme.areaGradient, isA<LinearGradient>());
      expect(theme.areaGradient?.colors.length, 3);
    });
  });
}
