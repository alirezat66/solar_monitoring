
import 'package:flutter/material.dart';
import 'package:monitoring_chart/src/theme/chart_theme_extension.dart';

class ChartTheme {
  // Light theme
  static final light = ChartThemeExtension(
    lineColor: const Color(0xFF2D3142), // Dark blue-gray
    lineWidth: 2.0,
    curveSmoothness: 0.2,
    areaGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF2D3142).withOpacity(0.15), // Dark blue-gray
        const Color(0xFF4F5D75).withOpacity(0.1), // Medium blue-gray
        Colors.white.withOpacity(0.05),
      ],
    ),
    horizontalGridLineColor: const Color(0xFFE5E5E5), // Light gray
    verticalGridLineColor: const Color(0xFFD3D3D3), // Lighter gray
    chartBorder: const BorderSide(
      color: Color(0xFFE5E5E5),
      width: 1,
    ),
    dotMainColor: const Color(0xFF2D3142), // Dark blue-gray
    dotBorderColor: Colors.white, // White border
    dotSecondaryColor: const Color(0xFF4F5D75), // Medium blue-gray
    filterSelectedColor: const Color(0xFF2D3142), // Dark blue-gray
    filterUnselectedColor: const Color(0xFFE5E5E5), // Light gray
  );

  // Dark theme
  static final dark = ChartThemeExtension(
    lineColor: const Color(0xFF61DAFB), // Bright cyan
    lineWidth: 2.0,
    curveSmoothness: 0.2,
    areaGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        const Color(0xFF61DAFB).withOpacity(0.2), // Bright cyan
        const Color(0xFF2C5364).withOpacity(0.15), // Dark teal
        Colors.black.withOpacity(0.1),
      ],
    ),
    horizontalGridLineColor: const Color(0xFF2C5364), // Dark teal
    verticalGridLineColor: const Color(0xFF203A43), // Darker teal
    chartBorder: const BorderSide(
      color: Color(0xFF2C5364),
      width: 1,
    ),
    dotMainColor: const Color(0xFF61DAFB), // Bright cyan
    dotBorderColor: Colors.black, // Black border
    dotSecondaryColor: const Color(0xFF2C5364), // Dark teal
    filterSelectedColor: const Color(0xFF61DAFB), // Bright cyan
    filterUnselectedColor: const Color(0xFF203A43), // Darker teal
  );
}
