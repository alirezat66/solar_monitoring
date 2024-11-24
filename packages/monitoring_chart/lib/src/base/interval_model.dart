import 'dart:math';

class IntervalModel {
  final double interval;
  final double lowerBound;
  final double upperBound;

  IntervalModel({
    required this.interval,
    required this.lowerBound,
    required this.upperBound,
  });

  factory IntervalModel.createNiceIntervals({
    num lowerBound = 0,
    required num upperBound,
  }) {
    assert(lowerBound != 0 || upperBound != 0, 'Both bounds cannot be zero');
    assert(lowerBound <= upperBound,
        'Lower bound must be smaller than upper bound');

    final double paddedLower = lowerBound * 0.995;
    final double paddedUpper = upperBound * 1.005;
    final range = paddedUpper - paddedLower;

    double interval = range / 5; 
    final magnitude = pow(10, (log(interval) / ln10).floor()).toDouble();
    final normalized = interval / magnitude;

    interval = _calculateNiceInterval(normalized, magnitude);

    final roundedLower = (paddedLower / interval).floor() * interval;
    final numberOfIntervals = ((paddedUpper - roundedLower) / interval).ceil();
    final roundedUpper = roundedLower + (interval * numberOfIntervals);

    return IntervalModel(
      interval: interval,
      lowerBound: roundedLower,
      upperBound: roundedUpper,
    );
  }

  static double _calculateNiceInterval(double normalized, double magnitude) {
    // Adjust thresholds for more consistent intervals
    if (normalized <= 1.2) return magnitude;
    if (normalized <= 2.5) return 2 * magnitude;
    if (normalized <= 5) return 5 * magnitude;
    return 10 * magnitude;
  }
}
