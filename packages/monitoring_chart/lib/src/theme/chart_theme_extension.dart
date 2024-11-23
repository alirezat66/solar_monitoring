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

  // Light theme
  static const light = ChartThemeExtension(
    lineColor: Color(0xFF3B3A3A),
    areaGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0x333B3A3A), // 0.2 opacity
        Color(0x33959393),
        Color(0x33FFFFFF),
      ],
    ),
    horizontalGridLineColor: Color(0xFFE5E5E5),
    verticalGridLineColor: Color(0xFF3B3A3A),
    chartBorder: BorderSide(
      color: Color(0xFFE5E5E5),
      width: 1,
    ),
    dotMainColor: Color(0xFF3B3A3A),
    dotBorderColor: Color(0xFF3B3A3A),
    dotSecondaryColor: Color(0xFF898989),
    filterSelectedColor: Color(0xFFECECEC),
    filterUnselectedColor: Color(0xFFECECEC),
  );

  // Dark theme
  static const dark = ChartThemeExtension(
    lineColor: Color(0xFFE5E5E5),
    areaGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0x33FFFFFF),
        Color(0x33959393),
        Color(0x333B3A3A),
      ],
    ),
    horizontalGridLineColor: Color(0xFF3B3A3A),
    verticalGridLineColor: Color(0xFFE5E5E5),
    chartBorder: BorderSide(
      color: Color(0xFF3B3A3A),
      width: 1,
    ),
    dotMainColor: Color(0xFFE5E5E5),
    dotBorderColor: Color(0xFFE5E5E5),
    dotSecondaryColor: Color(0xFF959393),
    filterSelectedColor: Color(0xFF3B3A3A),
    filterUnselectedColor: Color(0xFF3B3A3A),
  );

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
