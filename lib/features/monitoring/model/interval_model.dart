import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:solar_monitoring/core/extensions/fl_spots_extension.dart';

class IntervalModel {
  final double interval;
  final double min;
  final double max;

  IntervalModel({
    required this.interval,
    required this.min,
    required this.max,
  });

  factory IntervalModel.fromSpots(List<FlSpot> spots) {
    // Find min and max Y values
    final double minY = spots.minY;
    final double maxY = spots.maxY;

    // Match Chart.js padding of 1%
    final double minYPadded = minY * 0.99; // 1% padding below
    final double maxYPadded = maxY * 1.01; // 1% padding above
    final range = maxYPadded - minYPadded;

    // Calculate a nice interval that divides the range
    double interval = range / 5; // Start with 5 divisions as a base

    // Round interval to a nice number
    final magnitude = pow(10, (log(interval) / ln10).floor()).toDouble();
    final normalized = interval / magnitude;

    // Choose the nearest nice number
    if (normalized <= 1) {
      interval = magnitude;
    } else if (normalized <= 2) {
      interval = 2 * magnitude;
    } else if (normalized <= 5) {
      interval = 5 * magnitude;
    } else if (normalized <= 7.5) {
      interval = 10 * magnitude / 2; // This will give 5 * magnitude
    } else {
      interval = 10 * magnitude;
    }

    // Round minY down to nearest interval
    final roundedMinY = (minYPadded / interval).floor() * interval;

    // Calculate number of intervals needed
    final numberOfIntervals = ((maxYPadded - roundedMinY) / interval).ceil();

    // Calculate maxY
    final roundedMaxY = roundedMinY + (interval * numberOfIntervals);

    return IntervalModel(
      interval: interval,
      min: roundedMinY,
      max: roundedMaxY,
    );
  }
}
