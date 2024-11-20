import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:monitoring_models/monitoring_models.dart';
import 'package:solar_monitoring/features/monitoring/model/interval_model.dart';

extension MonitoringModelListExtension on List<MonitoringModel> {
  double get minY => map((e) => e.value.toDouble()).reduce(min);
  double get maxY => map((e) => e.value.toDouble()).reduce(max);

  IntervalModel get verticalInterval => IntervalModel.fromSpots(asMap()
      .entries
      .map(
          (entry) => FlSpot(entry.key.toDouble(), entry.value.value.toDouble()))
      .toList());

  List<FlSpot> normalizeToHours() {
    if (isEmpty) return [];

    // Find reference time (earliest time in the dataset)
    final referenceTime =
        map((e) => e.date).reduce((a, b) => a.isBefore(b) ? a : b);

    return asMap().entries.map((entry) {
      // Calculate hours difference for X-axis
      final hoursDiff = entry.value.date.difference(referenceTime).inHours;
      return FlSpot(
        hoursDiff.toDouble(),
        entry.value.value.toDouble(),
      );
    }).toList();
  }
}
