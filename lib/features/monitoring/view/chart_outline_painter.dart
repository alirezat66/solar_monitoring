import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:solar_monitoring/features/monitoring/view/chart_style.dart';

class FlDotOutlineCirclePainter extends FlDotPainter {
  FlDotOutlineCirclePainter({
    // Fixed size for outer circle: 20x20 means radius is 10
    this.outerCircleRadius = 10.0,
    // Center black circle: 12x12 means radius is 6
    this.innerCircleRadius = 6.0,
    this.outerStrokeWidth = 0.71,
    this.innerCircleStrokeWidth = 2.0,
  });

  final double outerCircleRadius;
  final double innerCircleRadius;
  final double outerStrokeWidth;
  final double innerCircleStrokeWidth;

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    // Draw outer stroke (most outer border)
    canvas.drawCircle(
      offsetInCanvas,
      outerCircleRadius,
      Paint()
        ..color = ChartStyle.dotBoarderColor.withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = outerStrokeWidth,
    );

    // Draw outer circle (gray background)
    canvas.drawCircle(
      offsetInCanvas,
      outerCircleRadius - outerStrokeWidth,
      Paint()
        ..color = ChartStyle.dotSecondColor.withOpacity(0.9)
        ..strokeWidth = 0.71
        ..style = PaintingStyle.stroke,
    );

    // Draw middle area
    canvas.drawCircle(
      offsetInCanvas,
      innerCircleRadius + innerCircleStrokeWidth + innerCircleStrokeWidth,
      Paint()
        ..color = ChartStyle.dotSecondColor.withOpacity(0.4)
        ..style = PaintingStyle.fill,
    );
    // Draw inner circle (black center)
    canvas.drawCircle(
      offsetInCanvas,
      innerCircleRadius,
      Paint()
        ..color = ChartStyle.dotMainColor
        ..style = PaintingStyle.fill,
    );
  }

  @override
  Size getSize(FlSpot spot) {
    // Fixed size 20x20
    return ChartStyle.dotSize;
  }

  @override
  List<Object?> get props => [
        outerCircleRadius,
        innerCircleRadius,
        outerStrokeWidth,
        innerCircleStrokeWidth,
      ];

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) {
    if (a is! FlDotOutlineCirclePainter || b is! FlDotOutlineCirclePainter) {
      return b;
    }
    return FlDotOutlineCirclePainter(
      outerCircleRadius:
          lerpDouble(a.outerCircleRadius, b.outerCircleRadius, t)!,
      innerCircleRadius:
          lerpDouble(a.innerCircleRadius, b.innerCircleRadius, t)!,
      outerStrokeWidth: lerpDouble(a.outerStrokeWidth, b.outerStrokeWidth, t)!,
      innerCircleStrokeWidth:
          lerpDouble(a.innerCircleStrokeWidth, b.innerCircleStrokeWidth, t)!,
    );
  }

  @override
  Color get mainColor => ChartStyle.dotMainColor;
}
