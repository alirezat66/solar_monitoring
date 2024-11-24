import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartThemeExtension extends ThemeExtension<ChartThemeExtension> {
  // Line styling
  final Color lineColor;
  final double lineWidth;
  final double curveSmoothness;

  // Area styling
  final LinearGradient? areaGradient;

  // Grid styling
  final Color horizontalGridLineColor;
  final double horizontalGridLineWidth;
  final Color verticalGridLineColor;
  final double verticalGridLineWidth;
  final List<int> verticalLineDashPattern;

  // Border styling
  final BorderSide chartBorder;

  // Dot styling
  final Color dotMainColor;
  final Color dotBorderColor;
  final Color dotSecondaryColor;
  final Size dotSize;

  // Layout
  final double chartAspectRatioPortrait;
  final double chartAspectRatioLandscape;

  // Filter styling
  final Color filterSelectedColor;
  final Color filterUnselectedColor;

  const ChartThemeExtension({
    this.lineColor = Colors.black,
    this.lineWidth = 1,
    this.curveSmoothness = 0.2,
    this.areaGradient,
    this.horizontalGridLineColor = Colors.grey,
    this.horizontalGridLineWidth = 1,
    this.verticalGridLineColor = Colors.grey,
    this.verticalGridLineWidth = 1,
    this.verticalLineDashPattern = const [2, 4],
    this.chartBorder = BorderSide.none,
    this.dotMainColor = Colors.black,
    this.dotBorderColor = Colors.black,
    this.dotSecondaryColor = Colors.grey,
    this.dotSize = const Size(20, 20),
    this.chartAspectRatioPortrait = 1.8,
    this.chartAspectRatioLandscape = 4,
    this.filterSelectedColor = Colors.grey,
    this.filterUnselectedColor = Colors.grey,
  });

  // Helper methods
  FlLine get horizontalGridLine => FlLine(
        color: horizontalGridLineColor,
        strokeWidth: horizontalGridLineWidth,
      );

  FlLine get verticalGridLine => FlLine(
        color: verticalGridLineColor,
        strokeWidth: verticalGridLineWidth,
        dashArray: verticalLineDashPattern,
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(bottom: chartBorder),
      );

  @override
  ChartThemeExtension copyWith({
    Color? lineColor,
    double? lineWidth,
    double? curveSmoothness,
    LinearGradient? areaGradient,
    Color? horizontalGridLineColor,
    double? horizontalGridLineWidth,
    Color? verticalGridLineColor,
    double? verticalGridLineWidth,
    List<int>? verticalLineDashPattern,
    BorderSide? chartBorder,
    Color? dotMainColor,
    Color? dotBorderColor,
    Color? dotSecondaryColor,
    Size? dotSize,
    double? chartAspectRatioLandscape,
    double? chartAspectRatioPortrait,
    Color? filterSelectedColor,
    Color? filterUnselectedColor,
  }) {
    return ChartThemeExtension(
      lineColor: lineColor ?? this.lineColor,
      lineWidth: lineWidth ?? this.lineWidth,
      curveSmoothness: curveSmoothness ?? this.curveSmoothness,
      areaGradient: areaGradient ?? this.areaGradient,
      horizontalGridLineColor:
          horizontalGridLineColor ?? this.horizontalGridLineColor,
      horizontalGridLineWidth:
          horizontalGridLineWidth ?? this.horizontalGridLineWidth,
      verticalGridLineColor:
          verticalGridLineColor ?? this.verticalGridLineColor,
      verticalGridLineWidth:
          verticalGridLineWidth ?? this.verticalGridLineWidth,
      verticalLineDashPattern:
          verticalLineDashPattern ?? this.verticalLineDashPattern,
      chartBorder: chartBorder ?? this.chartBorder,
      dotMainColor: dotMainColor ?? this.dotMainColor,
      dotBorderColor: dotBorderColor ?? this.dotBorderColor,
      dotSecondaryColor: dotSecondaryColor ?? this.dotSecondaryColor,
      dotSize: dotSize ?? this.dotSize,
      chartAspectRatioLandscape:
          chartAspectRatioLandscape ?? this.chartAspectRatioLandscape,
      chartAspectRatioPortrait:
          chartAspectRatioPortrait ?? this.chartAspectRatioPortrait,
      filterSelectedColor: filterSelectedColor ?? this.filterSelectedColor,
      filterUnselectedColor:
          filterUnselectedColor ?? this.filterUnselectedColor,
    );
  }

  @override
  ThemeExtension<ChartThemeExtension> lerp(
    covariant ThemeExtension<ChartThemeExtension>? other,
    double t,
  ) {
    if (other is! ChartThemeExtension) {
      return this;
    }

    return ChartThemeExtension(
      lineColor: Color.lerp(lineColor, other.lineColor, t)!,
      areaGradient: LinearGradient.lerp(areaGradient, other.areaGradient, t)!,
      horizontalGridLineColor: Color.lerp(
        horizontalGridLineColor,
        other.horizontalGridLineColor,
        t,
      )!,
      chartBorder: BorderSide.lerp(chartBorder, other.chartBorder, t),
      dotMainColor: Color.lerp(dotMainColor, other.dotMainColor, t)!,
      dotBorderColor: Color.lerp(dotBorderColor, other.dotBorderColor, t)!,
      dotSecondaryColor: Color.lerp(
        dotSecondaryColor,
        other.dotSecondaryColor,
        t,
      )!,
      dotSize: Size.lerp(dotSize, other.dotSize, t)!,
      filterSelectedColor: Color.lerp(
        filterSelectedColor,
        other.filterSelectedColor,
        t,
      )!,
      filterUnselectedColor: Color.lerp(
        filterUnselectedColor,
        other.filterUnselectedColor,
        t,
      )!,
      verticalGridLineColor: other.verticalGridLineColor,
    );
  }
}
