import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartStyle {
  static const Color dotMainColor = Color(0xFF3B3A3A);
  static const Color dotBoarderColor = Color(0xFF3B3A3A);
  static const Color dotSecondColor = Color(0xFF898989);
  static const Size dotSize = Size(20, 20);
  static const double chartAspectRatio = 2.1;

  static const Color filterSelectedColor = Color(0xffececec);
  static const Color filterUnSelectedColor = Color(0xffececec);
  static final flBorderData = FlBorderData(
    show: true,
    border: const Border(
      bottom: BorderSide(
        color: Color(0xFFE5E5E5), // Match with grid line color
        width: 1,
      ),
    ),
  );

  static const flHorizontalLine = FlLine(
    color: Color(0xFFE5E5E5), // Light gray color for horizontal lines
    strokeWidth: 1,
  );
  static const flVerticalLine = FlLine(
    color: Color(0xFF3B3A3A), // Black color
    strokeWidth: 1,
    dashArray: [
      2,
      4
    ], // This creates the dashed pattern [line_length, gap_length]
  );
  static final chartLinearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFF3B3A3A).withOpacity(0.2),
      const Color(0xFF959393).withOpacity(0.2),
      const Color(0xFFFFFFFF).withOpacity(0.2),
    ],
  );
}
